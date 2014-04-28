require 'csv'
require 'date'
require 'money'
require 'money-rails'

namespace :data do

	desc "Import stock quotes from the CSV files"
	task :import => :environment do	

		#LOOP THROUGH ALL COMPANIES CSV FILES IN THIS DIRECTORY
		i=0;
		Dir.foreach('inputData/stock_quotes') do |file|
			next if file == '.' or file == '..'
			break if i == 2

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
				break if t == 20

				date = Date.parse(row[0])
				price = row[6].to_f.round(2)

				#TODO: Create the Quote object with the stock quote data for this day
				@quote = @company.quotes.create(date: date, price: price);

				puts date.inspect + ", $" + price.to_s

			end #END CSV FILE PARSING

			i = i + 1
		end #END FILE PARSING


=begin		Investable.all.each do |investable|
			puts investable.name
		end
=end		

	end

	task :testmoney => :environment do	

		@quote = Quote.new
		@fifteen_dollars = Money.new(1500, "USD");
		
		@quote.amount = '15'
		puts assert_equal @fifteen_dollars, @quote.amount

	end

end