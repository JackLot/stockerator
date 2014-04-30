class InvestmentsController < ApplicationController

  include InvestmentsHelper

  def manual_input

  	inputString = params[:inputstring]

  	#REGEXs FOR DETERMINING WHAT TYPE OF ACTIVITY RECORD WAS SUBMITTED
  	fundRegex = /^[\s]*fund,[\s]*(.*),[\s]*([\d]*),[\s]*(\d{4}-\d{2}-\d{2})$/ 
  	indRegex = /^[\s]*individual,[\s]*(.*),[\s]*([\d]*),[\s]*(\d{4}-\d{2}-\d{2})$/ 
	buyOrSellRegex = /^[\s]*(buy|sell),[\s]*(.*),[\s]*(.*),[\s]*([\d]*),[\s]*(\d{4}-\d{2}-\d{2})$/
	sellBuyRegex = /^[\s]*(sellbuy),[\s]*(.*),[\s]*(.*),[\s]*(.*),[\s]*(\d{4}-\d{2}-\d{2})$/


	if(inputString =~ fundRegex) #CREATE FUND

		flash[:success] = "Matched fundRegex"

	elsif(inputString =~ indRegex) #CREATE INDIVIDUAL

		m = indRegex.match(inputString)

		if createIndividual(m[1], m[2], m[3])
			flash[:success] = "Successfully created individual #{m[1]}"
		else
			flash[:danger] = "Error creating individual. Please try again"
		end

	elsif(inputString =~ buyOrSellRegex) #BUY OR SELL SHARES

		flash[:success] = "Matched buyOrSellRegex"

	elsif(inputString =~ sellBuyRegex) #SELLBUY

		flash[:success] = "Matched sellBuyRegex"

	else
		flash[:danger] = "Incorrect string formatting. Record import unsuccessful."
        #redirect_to controller: :investments, action: :new
	end

	#flash[:info] = "inputstring: #{inputString}"

	redirect_to controller: :investments, action: :new

  end

  #Take in a CSV file
  def batch_process

  end

end
