namespace :jack do

	desc "Import stock quotes from the CSV files"
	task :import => :environment do	

		Investable.all.each do |investable|
			puts investable.name
		end
		
	end

end