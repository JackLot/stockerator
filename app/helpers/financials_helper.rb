module FinancialsHelper

	#RETURN: decimal percentage increase of the stock value over this time period
	def getStockAppriciation(company, start_date, end_date)

		#@company = Company.find_by(name: company)

		start_price = company.quotes.find_by(date: start_date).price_cents
		end_price = company.quotes.find_by(date: end_date).price_cents

		return (end_price.to_f / start_price)

	end

	def updateIndReturnAndNet (ind)

		noSellStocks = ind.individual_company_investments.where("sell_date IS NULL AND amount_cents != 0")
		noSellPorts = ind.individual_portfolio_investments.where("sell_date IS NULL AND amount_cents != 0")
			
		net = ind.individual_snapshots.last.amount_cents

		noSellStocks.each do |i|
			next if i.amount_cents == 0
			net = net + getCashValueOfCompanyInvestmentAtDate(i, Date.new(2013, 12, 31))

		end

		noSellPorts.each do |i|
			next if i.amount_cents == 0

			net = net + getCashValueOfPortfolioInvestmentAtDate(i, Date.new(2013, 12, 31))

		end

		ind.update(net_worth_cents: net)
		ind.update(total_return: (net.to_f/ind.cash_cents))

	end

	def getCashValueOfPortfolioInvestmentAtDate (investment, date)

		currentPortVal = getValueOfPortfolioAtDate(investment.portfolio, date)
		previousPortVal = getValueOfPortfolioAtDate(investment.portfolio, investment.buy_date)
		appriciation = currentPortVal.to_f / previousPortVal

		return (investment.amount_cents*appriciation)

	end

	def updateFundReturnAndNet (fund)

		noSell = fund.fund_company_investments.where("sell_date IS NULL AND amount_cents != 0")
			
		net = fund.portfolio_snapshots.last.amount_cents

		noSell.each do |i|
			next if i.amount_cents == 0

			net = net + getCashValueOfCompanyInvestmentAtDate(i, Date.new(2013, 12, 31))

		end

		fund.update(net_worth_cents: net)
		fund.update(total_return: (net.to_f/fund.cash_cents))

	end

	def test

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

		return appriciation * investment.amount_cents

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
	def getPercentageShareInFundAtDate(amount, fund, date)

		return (amount.cents.to_f / (amount.cents + getValueOfPortfolioAtDate(fund, date)))

	end

	def getValueOfPortfolioAtDate (fund, date)

		investments = fund.fund_company_investments.where("buy_date <= '#{date}'").where("sell_date IS NULL OR sell_date >= '#{date}'")
		inds = fund.individual_portfolio_investments.where("buy_date < '#{date}'").where("sell_date IS NULL OR sell_date > '#{date}'")

		c_investments = 0.0 #in cents
		i_investments = 0 #in cents
		cash = getFundSnapshotClosestToDate(fund, date).amount.cents #probably should be related to portfolio_snapshot

		#Total stock investments
		investments.each do |i|
			c_investments = c_investments.to_f + getCashValueOfCompanyInvestmentAtDate(i, date).to_f
		end

		#Total individual investments
		inds.each do |i|
			i_investments = i_investments + i.amount_cents
		end

		return cash + i_investments + c_investments

	end

	def getFundSnapshotClosestToDate (fund, date)

		return fund.portfolio_snapshots.where("date <= '#{date}'").order(date: :desc).last

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
 