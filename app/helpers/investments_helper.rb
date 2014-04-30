module InvestmentsHelper

	def createIndividual(name, startingCash, date)

		@investable = Investable.create(name: name)

		c = Monetize.parse(startingCash)
		d = Date.parse(date)

		if @investable.individuals.create(name: @investable.name, start_date: d, cash: c)
			return true
		else
			return false
		end

	end

	def createFund(name, startingCash, date)

	end

end
