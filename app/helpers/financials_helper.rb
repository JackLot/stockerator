module FinancialsHelper

	#RETURN: decimal percentage increase of the stock value over this time period
	def getStockAppriciation(company, start_date, end_date)

		@company = Company.find_by(name: company)

		start_price = @company.quotes.find_by(date: start_date).price_cents
		end_price = @company.quotes.find_by(date: end_date).price_cents

		return (end_price.to_f / start_price)

	end

	def findPriceQuoteClosestToDate(date, company)
		
	end

	#RETURN: decimal number of shares that amount buys on that given date
	def numShares(amount, date)

	end

end
 