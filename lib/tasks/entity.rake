require "#{Rails.root}/app/helpers/financials_helper"
include FinancialsHelper

namespace :entity do

	desc "Fill in fund return and net worth"
	task :fundreturnandnet => :environment do	

		portfolios = Portfolio.all

		portfolios.each_with_index do |p, i|

			puts "#{p.name}"
			updateFundReturnAndNet(p)

		end

	end

	desc "Fill in individual return and net worth"
	task :indreturnandnet => :environment do	

			individuals = Individual.all

			int = 0
			individuals.each_with_index do |p, i|
				i=i+1
				next if i<18

				puts "#{p.name}"
				updateIndReturnAndNet(p)

			end

	end

	desc "Fill in individual return and net worth"
	task :rollbackind => :environment do	

		IndividualPortfolioInvestment.delete_all
		IndividualCompanyInvestment.delete_all
		IndividualSnapshot.delete_all

	end

end