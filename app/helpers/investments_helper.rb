module InvestmentsHelper

	include FinancialsHelper

	def readInputString (inputString)


	#REGEXs FOR DETERMINING WHAT TYPE OF ACTIVITY RECORD WAS SUBMITTED
  	fundRegex = /^[\s]*fund,[\s]*(.*),[\s]*([\d]*),[\s]*(.*)$/ 
  	indRegex = /^[\s]*individual,[\s]*(.*),[\s]*([\d]*),[\s]*(.*)$/ 
	buyRegex = /^[\s]*(buy),[\s]*(.*),[\s]*(.*),[\s]*([\d]*),[\s]*(.*)$/
	sellRegex = /^[\s]*(sell),[\s]*(.*),[\s]*(.*),[\s]*(.*)$/
	sellBuyRegex = /^[\s]*(sellbuy),[\s]*(.*),[\s]*(.*),[\s]*(.*),[\s]*(.*)$/


	if(inputString =~ fundRegex) #CREATE FUND -------------------------------------------

		m = fundRegex.match(inputString)

		if createFund(m[1], m[2], m[3])
			flash[:success] = "Successfully created fund #{m[1]}"
		else
			if !flash[:danger] 
				flash[:danger] = "Error creating fund. Please try again"
			end
		end

	elsif(inputString =~ indRegex) #CREATE INDIVIDUAL -------------------------------------

		m = indRegex.match(inputString)

		if createIndividual(m[1], m[2], m[3])
			flash[:success] = "Successfully created individual #{m[1]}"
		else
			if !flash[:danger] 
				flash[:danger] = "Error creating individual. Please try again"
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

		flash[:info] = "got sellregex"
		m = sellRegex.match(inputString)

		if sellStock(m[2], m[3], m[4])
				flash[:success] = "#{m[2]} successfully sold all #{m[3]} stock!"
		else
			if !flash[:danger] 
				flash[:danger] = "Error selling shares. Please try again"
			end
		end

	elsif(inputString =~ sellBuyRegex) #SELLBUY ---------------------------------------------

		m = sellBuyRegex.match(inputString)

		if sellBuyStock(m[2], m[3], m[4], m[5])
				flash[:success] = "#{m[2]} successfully sold all #{m[3]} stock!"
		else
			if !flash[:danger] 
				flash[:danger] = "Error selling shares. Please try again"
			end
		end

	else
		if !flash[:danger] 
			flash[:danger] = "Error selling shares. Please try again"
		end
	end

	end

	def createIndividual(name, startingCash, date)

		if(Investable.find_by(name: name))
			flash[:danger] = "Individual/Portfolio already exists"
			return false
		end

		@investable = Investable.create(name: name, e_type: 1)

		c = Monetize.parse(startingCash)
		d = Date.parse(date)

		if @investable.individuals.create(name: @investable.name, start_date: d, cash: c)
			ind = Individual.find_by(name: @investable.name)
			ind.individual_snapshots.create(amount: c, date: d)
			return true
		else
			return false
		end

	end


	def createFund(name, startingCash, date)

		if(Investable.find_by(name: name))
			flash[:danger] = "Portfolio/Individual already exists"
			return false
		end

		@investable = Investable.create(name: name, e_type: 2)

		c = Monetize.parse(startingCash)
		d = Date.parse(date)

		if @investable.portfolios.create(name: @investable.name, start_date: d, cash: c, total_return: 1, net_worth: c)
			port = Portfolio.find_by(name: @investable.name)
			port.portfolio_snapshots.create(amount: c, date: d)
			return true
		else
			return false
		end

	end

	def validateDate(date)
				flash = {}


		minDate = Date.parse('2005-01-01')
		maxDate = Date.parse('2013-12-31')

		#VALIDATE THAT THE DATE IS WITHIN RANGE
		if(date > maxDate || date < minDate)
			flash[:danger] = "Error. Date out of range"
			return false
		end

		return true

	end


	def buyStock(investor_name, investee_name, amount, date)


		a = Monetize.parse(amount)
		d = Date.parse(date)

		if !validateDate(d) 
			return false 
		end

		#Figure out what type of entity the investor is
		@investor_investable = Investable.find_by(name: investor_name)

		#CHECK TO MAKE SURE THE INVESTOR ACTUALLY EXISTS
		if(!@investor_investable)
			flash[:danger] = "Error purchasing shares. Investor entity doesn't exist!"
			return false
		end

		investorType = @investor_investable.e_type

		if(investorType == 1)
			@investor = Individual.find_by(name: investor_name)

			#Check to make sure the investor has enough money
			if(getCashValueOfAllIndCompanyInvestmentsAtDate(@investor, d) <= a)
				flash[:danger] = "Error purchasing shares. Investor doesn't have enough cash"
				return false
			end

		elsif(investorType == 2)
			@investor = Portfolio.find_by(name: investor_name)
		else
			flash[:danger] = "Error purchasing shares. Companies cannot have investments"
			return false #Companies cannot invest in things
		end



		#Figure out what type of entity the investee is
		@investee_investable = Investable.find_by(name: investee_name)
		
		if(@investee_investable)
			investeeType = @investee_investable.e_type
		else
			flash[:danger] = "Error purchasing shares. Investee doesn't exist!"
			return false #Individuals cannot be invested in
		end

		if(investeeType == 0)
			@investee = Company.find_by(name: investee_name)
		elsif(investeeType == 2)
			@investee = Portfolio.find_by(name: investee_name)
		else
			flash[:danger] = "Error purchasing shares. Individuals cannot be invested in"
			return false #Individuals cannot be invested in
		end


		#Determining which investment to make and which model to use
		if investorType == 1 && investeeType == 0 #INDIVIDUAL COMPANY INVESTMENT

			i = @investor.individual_snapshots.last
			if(i.nil?)
				@investor.individual_snapshots.create(amount: @investor.cash, date: @investor.start_date)
			end

			if(@investor.individual_snapshots.last.amount <= a)
				flash[:danger] = "Error purchasing stock. Individual doesn't have enough cash"
				return false
			end

			returnVal = createIndCompanyInvestment(@investor, @investee, a, d)
			return returnVal

		elsif investorType == 2 && investeeType == 0 #FUND COMPANY INVESTMENT

			#Subtract out cash
			if(@investor.portfolio_snapshots.last.amount <= a)
				flash[:danger] = "Error purchasing stock. Portfolio doesn't have enough cash"
				return false
			end

			returnVal = createFundCompanyInvestment(@investor, @investee, a, d)
			updateFundReturnAndNet (@investor)

			return returnVal

		elsif investorType == 1 && investeeType == 2 #INDIVIDUAL PORTFOLIO INVESTMENT

			i = @investor.individual_snapshots.last
			if(i.nil?)
				@investor.individual_snapshots.create(amount: @investor.cash, date: @investor.start_date)
			end

			if(@investor.individual_snapshots.last.amount <= a)
				flash[:danger] = "Error purchasing stock. Individual doesn't have enough cash"
				return false
			end
			
			returnVal = createIndFundInvestment(@investor, @investee, a, d)
			return returnVal

		end

		return false

	end

	def sellStock(investor_name, investee_name, date)


		d = Date.parse(date)

		if !validateDate(d) 
			return false 
		end

		#Figure out what type of entity the investor is
		@investor_investable = Investable.find_by(name: investor_name)

		if(!@investor_investable)
			flash[:danger] = "Error selling shares. Investor entity doesn't exist!"
			return false
		end

		investorType = @investor_investable.e_type

		if(investorType == 1)
			@investor = Individual.find_by(name: investor_name)
		elsif(investorType == 2)
			@investor = Portfolio.find_by(name: investor_name)
		else
			flash[:danger] = "Error selling shares. Companies cannot have investments"
			return false #Companies cannot invest in things
		end

		#Figure out what type of entity the investee is
		@investee_investable = Investable.find_by(name: investee_name)
		if(!@investee_investable)
			flash[:danger] = "Error selling shares. Investor entity doesn't exist!"
			return false
		end

		investeeType = @investee_investable.e_type

		if(investeeType == 0)
			@investee = Company.find_by(name: investee_name)
		elsif(investeeType == 2)
			@investee = Portfolio.find_by(name: investee_name)
		else
			flash[:danger] = "Error selling shares. Individuals cannot be invested in"
			return false #Individuals cannot be invested in
		end

		#Determining which investment to make and which model to use
		if investorType == 1 && investeeType == 0 #INDIVIDUAL COMPANY INVESTMENT

			return sellIndCompanyInvestment(@investor, @investee, d)

		elsif investorType == 2 && investeeType == 0 #FUND COMPANY INVESTMENT

			returnVal = sellFundCompanyInvestment(@investor, @investee, d)
			updateFundReturnAndNet (@investor)
			return returnVal

		elsif investorType == 1 && investeeType == 2 #INDIVIDUAL PORTFOLIO INVESTMENT

			return sellIndFundInvestment(@investor, @investee, d)

		end

		return false

	end

	def sellBuyStock (investor, investee, newInvestee, date)


		#Figure out what type of entity the newInvestee is
		@investee_investable = Investable.find_by(name: newInvestee)
		
		if(!@investee_investable)
			flash[:danger] = "Error sellbuying shares. Investee doesn't exist!"
			return false
		end

		investeeType = @investee_investable.e_type
		if(investeeType == 1)
			flash[:danger] = "Error sellbuying shares. Individuals cannot be invested in"
			return false
		end

		#Sell the stock -------------------------------------------
		if !sellStock(investor, investee, date)
			return false
		end

		#Figure out what type of entity the investor is
		@investor_investable = Investable.find_by(name: investor)

		if(!@investor_investable)
			flash[:danger] = "Error selling shares. Investor entity doesn't exist!"
			return false
		end
		
		investorType = @investor_investable.e_type

		if(investorType == 1)
			@investor = Individual.find_by(name: investor)
			lastTwo = @investor.individual_snapshots.last(2)
		elsif(investorType == 2)
			@investor = Portfolio.find_by(name: investor)
			lastTwo = @investor.portfolio_snapshots.last(2)
		else
			flash[:danger] = "Error selling shares. Companies cannot have investments"
			return false #Companies cannot invest in things
		end

		buyAmount = lastTwo[1].amount - lastTwo[0].amount

		#Buy new stock ---------------------------------------------
		return buyStock(investor, newInvestee, buyAmount.format, date)

	end

	# ---------------------------------------------------------------------------------------------------------
	# ******************************************  BUYING SHARES  **********************************************
	# ---------------------------------------------------------------------------------------------------------

	def createIndCompanyInvestment(ind, company, amount, date)

		if(ind.companies.find_by(name: company.name))
			flash[:danger] = "Error purchasing shares. Individual already purchased stock in #{company.name}"
			return false
		end

		returnVal = ind.individual_company_investments.create(amount: amount, buy_date: date, company_id: company.id)

		updateIndividualSnapshot(ind, amount.cents*(-1), date)

		return returnVal

	end

	def createFundCompanyInvestment(fund, company, amount, date)

		if(fund.companies.find_by(name: company.name))
			flash[:danger] = "Error purchasing shares. Portfolio already purchased stock in #{company.name}"
			return false
		end

		temp = fund.fund_company_investments.create(amount: amount, buy_date: date, company_id: company.id)

		updatePortfolioSnapshot(fund, amount.cents*(-1), date)

		return temp

	end

	def createIndFundInvestment(ind, fund, amount, date)


		if(ind.portfolios.find_by(name: fund.name))
			flash[:danger] = "Error purchasing shares. Individual already purchased stock in #{fund.name}"
			return false
		end

		percentageShare = getPercentageShareInFundAtDate(amount, fund, date)

		returnVal = ind.individual_portfolio_investments.create(amount: amount, buy_date: date, portfolio_id: fund.id, percentage: percentageShare)

		updateIndividualSnapshot(ind, amount.cents*(-1), date)

		return returnVal

	end

	# ---------------------------------------------------------------------------------------------------------
	# ******************************************  SELLING SHARES  *********************************************
	# ---------------------------------------------------------------------------------------------------------

	def sellIndCompanyInvestment(ind, company, date)


		if(!ind.companies.find_by(name: company.name))
			flash[:danger] = "Error selling shares. Individual never bought stock in #{company.name}"
			return false
		end

		investment = ind.individual_company_investments.find_by(company_id: company.id)

		if(investment.sell_date != nil)
			flash[:danger] = "Error selling shares. Individual already sold stock in #{company.name}"
			return false
		end

		if(date <= investment.buy_date)
			flash[:danger] = "Error selling shares. Individual cannot sell stock before/on-the-day they bought it"
			return false
		end

		returnVal = investment.update(sell_date: date)

		updateIndividualSnapshot(ind, getCashValueOfCompanyInvestmentAtDate(investment, date), date)

		return returnVal

	end

	def sellFundCompanyInvestment(fund, company, date)

		if(!fund.companies.find_by(name: company.name))
			flash[:danger] = "Error selling shares. Fund never bought stock in #{company.name}"
			return false
		end

		investment = fund.fund_company_investments.find_by(company_id: company.id)

		if(investment.sell_date != nil)
			flash[:danger] = "Error selling shares. Fund already sold stock in #{company.name}"
			return false
		end

		if(date <= investment.buy_date)
			flash[:danger] = "Error selling shares. Fund cannot sell stock before/on-the-day they bought it"
			return false
		end

		temp = investment.update(sell_date: date)

		updatePortfolioSnapshot(fund, getCashValueOfCompanyInvestmentAtDate(investment, date), date)

		return temp

	end

	def sellIndFundInvestment(ind, fund, date)


		if(!fund.individuals.find_by(name: ind.name))
			flash[:danger] = "Error selling shares. Individual never bought stock in #{fund.name}"
			return false
		end

		investment = fund.individual_portfolio_investments.find_by(individual_id: ind.id)

		if(investment.sell_date != nil)
			flash[:danger] = "Error selling shares. Individual already sold stock in #{fund.name}"
			return false
		end

		if(date <= investment.buy_date)
			flash[:danger] = "Error selling shares. Invidual cannot sell stock before/on-the-day they bought it"
			return false
		end

		returnVal = investment.update(sell_date: date)

		currentPortVal = getValueOfPortfolioAtDate(investment.portfolio, date)
		previousPortVal = getValueOfPortfolioAtDate(investment.portfolio, investment.buy_date)
		appriciation = currentPortVal.to_f / previousPortVal

		#flash[:info] = "#{appriciation}"

		updateIndividualSnapshot(ind, (investment.amount_cents*appriciation), date)

		return returnVal

	end

	def updatePortfolioSnapshot(fund, amount, date)

		p = fund.portfolio_snapshots.last
		if(p.nil?)
			fund.portfolio_snapshots.create(amount: ind.cash, date: ind.start_date)
		end

		prevAmount = p.amount_cents
		fund.portfolio_snapshots.create(date: date, amount_cents: (prevAmount + amount))

	end

	def updateIndividualSnapshot(ind, amount, date)
	

		i = ind.individual_snapshots.last
		if(i.nil?)
			ind.individual_snapshots.create(amount: ind.cash, date: ind.start_date)
		end

		prevAmount = i.amount_cents
		ind.individual_snapshots.create(date: date, amount_cents: (prevAmount + amount))

	end

=begin
	def updateIndividualSnapshot(ind, amount, date)

		prevAmount = ind.ind_snapshots.last.amount_cents
		ind.ind_snapshot.create(date: date, amount_cents: (prevAmount + amount))

	end
=end

end
