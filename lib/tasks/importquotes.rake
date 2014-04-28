require 'csv'
require 'date'
require 'money'
require 'money-rails'
require 'monetize'

namespace :data do

	desc "Import stock quotes from the CSV files"
	task :import => :environment do	

		#LOOP THROUGH ALL COMPANIES CSV FILES IN THIS DIRECTORY
		i = -2;
		Dir.foreach('inputData/stock_quotes') do |file|
			i = i + 1
			next if file == '.' or file == '..'
			next if i <= 83
			break if i >= 115

			filePath = 'inputData/stock_quotes/' + file

			companyName = /(.*).csv/.match(file)[1]
			#puts "----------------------------------"
			puts "Importing: #{companyName}"
			#puts "----------------------------------"

			#TODO: Create the Investable object with the company name
			@investable = Investable.create(name: companyName, isCompany: true);

			#TODO: Create the Company object with the company name
			@company = @investable.companies.create(name: @investable.name);

			#PARSE EACH ROW OF THE COMPANIES STOCK PRICE CSV FILE
			t = -1
			CSV.foreach(filePath) do |row|

				t=t+1
				next if t == 0
				#break if t == 20

				date = Date.parse(row[0])
				price = Monetize.parse(row[6])

				#TODO: Create the Quote object with the stock quote data for this day
				@quote = @company.quotes.create(date: date, price: price);

				#puts date.inspect + ", " + price.format

			end #END CSV FILE PARSING

			
		end #END FILE PARSING


=begin		Investable.all.each do |investable|
			puts investable.name
		end
=end		

	end

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

end