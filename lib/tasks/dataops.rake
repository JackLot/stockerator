require 'csv'
require 'date'
require 'money'
require 'money-rails'
require 'monetize'
require 'activerecord-import'

require "#{Rails.root}/app/helpers/financials_helper"
include FinancialsHelper

require "#{Rails.root}/app/helpers/investments_helper"
include InvestmentsHelper


namespace :data do

	desc "Import stock quotes from the CSV files"
	task :import => :environment do	

		#LOOP THROUGH ALL COMPANIES CSV FILES IN THIS DIRECTORY
		i = -2
		Dir.foreach('inputData/stock_quotes') do |file|
			i = i + 1
			next if file == '.' or file == '..'
			#next if i <= 115 #EXCLUSIVE
			#break if i > 115 #INCLUSIVE

			filePath = 'inputData/stock_quotes/' + file

			companyName = /(.*).csv/.match(file)[1]

			puts "Importing: #{companyName}"

			@investable = Investable.create(name: companyName, isCompany: true);
			@company = @investable.companies.create(name: @investable.name);

			#PARSE EACH ROW OF THE COMPANIES STOCK PRICE CSV FILE
			t = -1
			quotes = []
			CSV.foreach(filePath) do |row|

				t=t+1
				next if t == 0
				#break if t == 20

				date = Date.parse(row[0])
				price = Monetize.parse(row[6])

				quotes << Quote.new(date: date, price: price, company_id: @company.id)
				#@quote = @company.quotes.create(date: date, price: price);

			end #END CSV FILE PARSING

			#Batch import using activerecord-import
			Quote.import(quotes)
			
		end #END FILE PARSING

	end


	desc "Goes through and checks if a companies stock value 
			strictly increases every year. Sets in DB if true"
	task :markcomps => :environment do	

		#Loop through all the companies
		Company.all.each do |c|

			currentYear = nil
			currentYearPrice = nil
			previousYearPrice = nil
			previousQuote = nil

			strictlyIncreasing = true

			c.quotes.each do |quote|	

				#Set current year if I hasn't been already
				if currentYear == nil
					currentYear = quote.date.year
				end

				#We got to the place where the quotes switch to a new year
				#meaning that the previousQuote will be set to the opening stock quote of this year
				if(quote.date.year != currentYear)

					#If this is the first year of quotes we've looked at
					if(previousYearPrice == nil)
						currentYearPrice = previousQuote.price
						previousYearPrice = previousQuote.price
						next
					end

					currentYearPrice = previousQuote.price

					#Check to make sure that the previous year is smaller
					if(currentYearPrice > previousYearPrice)
						strictlyIncreasing = false
					end

					previousYearPrice = currentYearPrice

					#Reset current year to the new year we iterated to
					currentYear = quote.date.year

				end

				break if strictlyIncreasing == false
				previousQuote = quote

			end

			#Final comparison for the 2005 year
			if(previousQuote.price > previousYearPrice)
				strictlyIncreasing = false
			end

			#Set strictlyIncreasing in the database
			if(strictlyIncreasing == true)
				c.update(strict_increasing: true)
			end
			puts "#{c.name} is #{strictlyIncreasing}"

		end

	end

	desc "Goes through and calculates risk for each stock. Saves it in the DB"
	task :stockrisk => :environment do	

		i=0
		#Loop through each company
		Company.all.each do |c|
			i=i+1
			#break if i > 2

			puts "COMPANY: #{c.name}"

			largestLocalMax = nil
			maxDrop = 0.0
			temp = nil
			t=0
			
			#Loop through each stock price
			c.quotes.reverse_each do |quote|

				t=t+1
				#break if t > 100

				#puts "\nLooking at #{quote.price} on #{quote.date.strftime("%m-%d-%Y")}---------------"

				if(largestLocalMax == nil)
					#puts "  **Found new high #{quote.price}"
					largestLocalMax = quote.price_cents
					next
				end

				#If there was a drop in stock price
				if(quote.price_cents < largestLocalMax)

					difference = (largestLocalMax - quote.price_cents).to_f
					percentDrop = difference / largestLocalMax

					#puts "    percentDrop: #{percentDrop}"

					if(percentDrop > maxDrop)
						maxDrop = percentDrop
						temp = quote
						#puts "    >>>>new maxDrop: #{maxDrop}"
					end

				#If we found a new largest local max value	
				elsif quote.price_cents > largestLocalMax
					#puts "  ** Found new high #{quote.price}"
					largestLocalMax = quote.price_cents
				end

			end

			puts "   risk[largestLocalMax: #{largestLocalMax}, temp: #{temp.date}, #{temp.price}]: #{maxDrop}"
			c.update(risk: maxDrop)

		end

	end

	desc "Goes through and calculates risk for each stock. Saves it in the DB"
	task :stockreturn => :environment do	

		i=0
		#Loop through each company
		Company.all.each do |c|
			i=i+1
			#break if i > 4

			mostRecent = c.quotes.first
			oldest = c.quotes.last

			totalReturn = mostRecent.price_cents.to_f / oldest.price_cents

			c.update(total_return: totalReturn)
			puts "Company: #{c.name}, total_return: #{totalReturn}"

		end

	end

	desc "Goes through and calculates annualized rate of return for each stock. Saves it in the DB"
	task :stockaror => :environment do	

		i=0
		#Loop through each company
		Company.all.each do |c|
			i=i+1
			#break if i > 4
			#next if c.annualized_ror != nil

			#aror = c.total_return.power(1.0/8.0) - 1
			aror2 = (c.total_return.to_f ** (1.0/9)) - 1

			c.update(annualized_ror: aror2)
			puts "Company: #{c.name}, annualized_ror: #{aror2}"

		end

	end

	desc "Adds company names to the database of companies"
	task :addnames => :environment do	

		t = 0
		CSV.foreach('inputData/sp500_names.csv') do |row|

			t=t+1
			next if t == 1
			#break if t == 3

			puts "Added #{row[1]} --> #{row[2]}"

			company = Company.find_by(name: row[1])

			if company != nil
				company.update(full_name: row[2])
			end

		end #END CSV FILE PARSING

	end

	desc "Fill in stock market off dates with offsets and prices from the next day of open trading"
	task :addfillerdates => :environment do	

		quotesBuffer = []
		i = 0

		#COMPANY LOOP
		Company.all.each do |c|
			i=i+1
			#break if i > 2

			puts "Company: #{c.name}"

			quotes = c.quotes.order(date: :desc)

			t = 0
			previous = quotes.first

			w = 1
			#QUOTES LOOP
			quotes.each do |q|
				t=t+1
				next if t == 1
				#break if t > 100

				#If the dates are not contiguous
				if(q.date != (previous.date - 1))

					off = (previous.date - q.date).to_i - 1
					#puts "offset: #{off}"
					filler = (q.date + 1)
					#puts ">>> Filler: #{off}, #{filler}"

					while filler < previous.date

						#puts ">>> Filler: #{off}, #{filler}"
						#w=w+1
						quotesBuffer << Quote.new(date: filler, price: previous.price, company_id: c.id, offset: off)

						filler = filler + 1
						off = off - 1

					end

				end

				#puts "#{q.date}"
				previous = q
				#Create a variable that holds the previously seen date
			end

			#puts "NUM FILLERS: #{w}"

		end

		Quote.import(quotesBuffer)


	end

	desc "Import stock quotes from the CSV files"
	task :importscript => :environment do	

		#PARSE EACH ROW OF THE COMPANIES STOCK PRICE CSV FILE
		t = 0
		CSV.foreach('inputData/test_scripts/script4.csv') do |row|

			t=t+1
			next if t == 0

			next if row[0] =~ /individual|fund/ #Skip creates
			next if row[1] =~ /fund.*/ #Skip creates
			next if row[3] == "0" #Ignore zero dollar transactions


			#TODO: IGNORE BUYS FOR ZERO DOLLARS

			if row[0] == "sellbuy" || row[0] == "buy"
				inputString = "#{row[0]}, #{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}"
			else
				inputString = "#{row[0]}, #{row[1]}, #{row[2]}, #{row[3]}"
			end

			puts "#{inputString}"
			readInputString(inputString)

			#@quote = @company.quotes.create(date: date, price: price);

		end #END CSV FILE PARSING


	end


=begin
	desc "Generate a numbered list of all companies, using CSV files folder"
	task :companylist => :environment do	

		i = -2;
		Dir.foreach('inputData/stock_quotes') do |file|

			i = i + 1
			next if file == '.' or file == '..'
			#next if i < 80
			break if i >= 80

			filePath = 'inputData/stock_quotes/' + file

			companyName = /(.*).csv/.match(file)[1]
			#puts "----------------------------------"
			puts "#{i}: #{companyName}"
			#puts "----------------------------------"

			
		end #END FILE PARSING

	end
=end

end