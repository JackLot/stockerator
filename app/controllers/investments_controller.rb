require 'csv'

class InvestmentsController < ApplicationController

  include InvestmentsHelper

  def manual_input

  	inputString = params[:inputstring]

  	#REGEXs FOR DETERMINING WHAT TYPE OF ACTIVITY RECORD WAS SUBMITTED
  	fundRegex = /^[\s]*fund,[\s]*(.*),[\s]*([\d]*),[\s]*(\d{4}-\d{2}-\d{2})$/ 
  	indRegex = /^[\s]*individual,[\s]*(.*),[\s]*([\d]*),[\s]*(\d{4}-\d{2}-\d{2})$/ 
	buyRegex = /^[\s]*(buy),[\s]*(.*),[\s]*(.*),[\s]*([\d]*),[\s]*(\d{4}-\d{2}-\d{2})$/
	sellRegex = /^[\s]*(sell),[\s]*(.*),[\s]*(.*),[\s]*(\d{4}-\d{2}-\d{2})$/
	sellBuyRegex = /^[\s]*(sellbuy),[\s]*(.*),[\s]*(.*),[\s]*(.*),[\s]*(\d{4}-\d{2}-\d{2})$/


	if(inputString =~ fundRegex) #CREATE FUND -------------------------------------------

		m = fundRegex.match(inputString)

		if createFund(m[1], m[2], m[3])
			flash[:success] = "Successfully created individual #{m[1]}"
		else
			if !flash[:danger] 
				flash[:danger] = "Error creating individual. Please try again"
			end
		end

	elsif(inputString =~ indRegex) #CREATE INDIVIDUAL -------------------------------------

		m = indRegex.match(inputString)

		if createIndividual(m[1], m[2], m[3])
			flash[:success] = "Successfully created fund #{m[1]}"
		else
			if !flash[:danger] 
				flash[:danger] = "Error creating fund. Please try again"
			end
		end

	elsif(inputString =~ buyRegex) #BUY SHARES -------------------------------

		m = buyRegex.match(inputString)

		if buyStock(m[2], m[3], m[4], m[5])
			flash[:success] = "#{m[2]} successfully bought $#{m[4]} worth of #{m[3]}!"
		else
			if !flash[:danger] 
				flash[:danger] = "Error purchasing shares. Please try again"
			end
		end

			

	elsif(inputString =~ sellRegex) #SELL SHARES -------------------------------

		m = sellRegex.match(inputString)

		if sellStock(m[2], m[3], m[4])
				flash[:success] = "#{m[2]} successfully sold all #{m[3]} stock!"
		else
			if !flash[:danger] 
				flash[:danger] = "Error selling shares. Please try again"
			end
		end

	elsif(inputString =~ sellBuyRegex) #SELLBUY ---------------------------------------------

		flash[:success] = "Matched sellBuyRegex. No implementation yet"

	else
		flash[:danger] = "Incorrect string formatting. Record import unsuccessful."
        #redirect_to controller: :investments, action: :new
	end

	#flash[:info] = "inputstring: #{inputString}"
	#flash

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
