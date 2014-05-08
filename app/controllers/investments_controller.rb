require 'csv'

class InvestmentsController < ApplicationController

  include InvestmentsHelper

  def manual_input

  	inputString = params[:inputstring]

  	readInputString(inputString)

	redirect_to controller: :investments, action: :new

  end

  #Take in a CSV file
  def process_csv_file

  	csvfile = params[:file]

  	@rowArray = CSV.read(csvfile.path)

  	@rowArray.each do |row|

		flash[:info] = "First Row: #{row.inspect}"
		break

	end #END CSV FILE PARSING

  	
  	redirect_to controller: :investments, action: :new

  end

  def delete_all

  	Investable.destroy_all "e_type = 1 OR e_type = 2"
=begin
  	Investable.delete_all "e_type = 1 OR e_type = 2"
  	Individual.delete_all
  	Portfolio.delete_all
  	IndividualPortfolioInvestment.delete_all
  	IndividualCompanyInvestment.delete_all
  	FundCompanyInvestment.delete_all
=end

  	flash[:info] = "Done."
  	redirect_to controller: :investments, action: :new
  end

end
