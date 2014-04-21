require 'csv'
require 'date'

namespace :jack do

	desc "Import stock quotes from the CSV files"
	task :import => :environment do	

		#LOOP THROUGH ALL COMPANIES CSV FILES IN THIS DIRECTORY
		i=0;
		Dir.foreach('inputData/stock_quotes') do |file|
			next if file == '.' or file == '..'
			break if i == 1

			filePath = 'inputData/stock_quotes/' + file

			companyName = /(.*).csv/.match(file)[1]
			puts "----------------------------------"
			puts companyName
			puts "----------------------------------"

			#TODO: Create the Investable object with the company name
			#TODO: Create the Company object with the company name

			#PARSE EACH ROW OF THE COMPANIES STOCK PRICE CSV FILE
			t = -1
			CSV.foreach(filePath) do |row|
				t=t+1
				next if t == 0
				break if t == 6

				date = Date.parse(row[0])
				price = row[3].to_f

				#TODO: Create the Quote object with the stock quote data for this day

				puts date.inspect + ", $" + price.to_s

			end #END CSV FILE PARSING

			i = i + 1
		end #END FILE PARSING


=begin		Investable.all.each do |investable|
			puts investable.name
		end
=end		

	end

end