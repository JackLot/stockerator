module InvestmentsHelper

	def createIndividual(name, startingCash, date)

		@investable = Investable.create(name: name, e_type: 1)

		c = Monetize.parse(startingCash)
		d = Date.parse(date)

		if @investable.individuals.create(name: @investable.name, start_date: d, cash: c)
			return true
		else
			return false
		end

	end


	def createFund(name, startingCash, date)

		@investable = Investable.create(name: name, e_type: 2)

		c = Monetize.parse(startingCash)
		d = Date.parse(date)

		if @investable.portfolios.create(name: @investable.name, start_date: d, cash: c)
			return true
		else
			return false
		end

	end


	def buyStock(investor_name, investee_name, amount, date)

		a = Monetize.parse(amount)
		d = Date.parse(date)

		#Figure out what type of entity the investor is
		@investor_investable = Investable.find_by(name: investor_name)
		investorType = @investor_investable.e_type

		if(investorType == 1)
			@investor = Individual.find_by(name: investor_name)
		elsif(investorType == 2)
			@investor = Portfolio.find_by(name: investor_name)
		else
			return false #Companies cannot invest in things
		end

		#Figure out what type of entity the investee is
		@investee_investable = Investable.find_by(name: investee_name)
		investeeType = @investee_investable.e_type

		if(investeeType == 0)
			@investee = Company.find_by(name: investee_name)
		elsif(investeeType == 2)
			@investee = Portfolio.find_by(name: investee_name)
		else
			return false #Individuals cannot be invested in
		end

		#Determining which investment to make and which model to use
		if investorType == 1 && investeeType == 0 #INDIVIDUAL COMPANY INVESTMENT
			return createIndCompanyInvestment(@investor, @investee, a, d)
		elsif investorType == 2 && investeeType == 0 #FUND COMPANY INVESTMENT
			return createFundCompanyInvestment(@investor, @investee, a, d)
		elsif investorType == 1 && investeeType == 2 #INDIVIDUAL PORTFOLIO INVESTMENT
		
		end

		return false

	end

	def createIndCompanyInvestment(ind, company, amount, date)

		return ind.individual_company_investments.create(amount: amount, buy_date: date, company_id: company.id)

	end

	def createFundCompanyInvestment(fund, company, amount, date)

		return fund.fund_company_investments.create(amount: amount, buy_date: date, company_id: company.id)

	end

	def createIndFundInvestment

	end

end
