module FinancialsHelper

	#RETURN: decimal percentage increase of the stock value over this time period
	def getStockAppriciation(company, start_date, end_date)

		#@company = Company.find_by(name: company)

		start_price = company.quotes.find_by(date: start_date).price_cents
		end_price = company.quotes.find_by(date: end_date).price_cents

		return (end_price.to_f / start_price)

	end


	#If date is after sell date of the investment. Cash value is zero because you don't
	#hold the stock anymore and have sold it for cash already
	def getTheoreticalValueOfCompanyInvestmentAtDate(investment, date)

		if !investment.sell_date
			s_date = Date.new(2013, 12, 31)
		else
			s_date = investment.sell_date
		end

		if (!(s_date > date) || !(investment.buy_date < date))
			return 0
		end

		appriciation = getStockAppriciation(investment.company, investment.buy_date, date)

		return appriciation*investment.amount

	end

	#If the date is after the stock has been sold it return cash
	#else, you still have the stock and it returns 0
	def getCashValueOfCompanyInvestmentAtDate(investment, date)


		if investment.sell_date.nil?
			s_date = Date.new(2013, 12, 31)
		else
			s_date = investment.sell_date
		end


		if (s_date > date && investment.buy_date <= date)

			return (investment.amount)*(-1)

		elsif(investment.buy_date > date)

			return 0

		end

		appriciation = getStockAppriciation(investment.company, investment.buy_date, s_date)

		return appriciation * investment.amount

	end

	def getCashValueOfAllIndCompanyInvestmentsAtDate(ind, date)

		totalCash = ind.cash

		ind.individual_company_investments.each do |i|

			#totalCash = totalCash + getCashValueOfCompanyInvestmentAtDate(i, date)

		end

		return totalCash

	end



	#TODO: ADD IN PORTFOLIO CALCULATIONS ALONG WITH COMPANY INVESTMENTS
	def getTotalNetWorth (ind)

		return getCashValueOfAllIndCompanyInvestmentsAtDate(ind, Date.new(2013, 12, 31)) + getTotalValueOfAllFundInvestments(ind, Date.new(2013, 12, 31))

	end


	def getTotalInvestmentROI (investment)

		newCash = investment.amount_cents * getStockAppriciation(investment.company, investment.buy_date, getSellDate(investment))
		profit = newCash - investment.amount_cents

		return profit.to_f/investment.amount_cents

	end

	def getSellDate (investment)
		if !investment.sell_date
			s_date = Date.new(2013, 12, 31)
		else
			s_date = investment.sell_date
		end

		return s_date
	end


	#Returns individuals percentage share in the portfolio on a given date. Can be zero
	def getIndividualPercentageShareInFundAtDate(ind, date)

		

	end

	#Given two dates return the apprication of all stocks in that fund during that time period
	def getFundAppriciationOverTime(port, start_date, end_date)

		

	end

	#Given a ind-fund investment return how much that investment is worth at a certain date
	def getCashValueOfIndFundInvestment(ind, fund, date)

		

	end

	#Get real cash value of all fund investments
	def getTotalValueOfAllFundInvestments(ind, date)

	end


	#RETURN: decimal number of shares that amount buys on that given date
	def numShares(amount, date)

	end

end
 