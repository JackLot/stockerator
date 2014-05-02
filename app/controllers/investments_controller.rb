class InvestmentsController < ApplicationController

  include InvestmentsHelper

  def manual_input

  	inputString = params[:inputstring]

  	#REGEXs FOR DETERMINING WHAT TYPE OF ACTIVITY RECORD WAS SUBMITTED
  	fundRegex = /^[\s]*fund,[\s]*(.*),[\s]*([\d]*),[\s]*(\d{4}-\d{2}-\d{2})$/ 
  	indRegex = /^[\s]*individual,[\s]*(.*),[\s]*([\d]*),[\s]*(\d{4}-\d{2}-\d{2})$/ 
	buyOrSellRegex = /^[\s]*(buy|sell),[\s]*(.*),[\s]*(.*),[\s]*([\d]*),[\s]*(\d{4}-\d{2}-\d{2})$/
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

	elsif(inputString =~ buyOrSellRegex) #BUY OR SELL SHARES -------------------------------

		m = buyOrSellRegex.match(inputString)

		if m[1] == "buy" #BUY SHARES

			if buyStock(m[2], m[3], m[4], m[5])
				flash[:success] = "#{m[2]} successfully bought $#{m[4]} worth of #{m[3]}!"
			else
				if !flash[:danger] 
					flash[:danger] = "Error purchasing shares. Please try again"
				end
			end

		else
			if sellStock(m[2], m[3], m[4], m[5])
				flash[:success] = "#{m[2]} successfully sold $#{m[4]} worth of #{m[3]}!"
			else
				if !flash[:danger] 
					flash[:danger] = "Error selling shares. Please try again"
				end
			end
		end

	elsif(inputString =~ sellBuyRegex) #SELLBUY ---------------------------------------------

		flash[:success] = "Matched sellBuyRegex. No implementation yet"

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
