require 'csv'
require 'date'
require 'money'
require 'money-rails'
require 'monetize'
require 'activerecord-import'

namespace :data do

	desc "Fill in stock market off dates with offsets and prices from the next day of open trading"
	task :fundreturnandnet => :environment do	

		portfolios = Portfolio.all

		portfolios.each do |p|

			puts "#{p.name}"
			updateFundReturnAndNet(p)

		end

	end

end