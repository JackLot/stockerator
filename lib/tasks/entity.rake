require "#{Rails.root}/app/helpers/financials_helper"
include FinancialsHelper

namespace :entity do

	desc "Fill in stock market off dates with offsets and prices from the next day of open trading"
	task :fundreturnandnet => :environment do	

		portfolios = Portfolio.all

		portfolios.each_with_index do |p, i|

			puts "#{p.name}"
			updateFundReturnAndNet(p)

		end

	end

end