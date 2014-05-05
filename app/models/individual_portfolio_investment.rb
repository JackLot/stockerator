class IndividualPortfolioInvestment < ActiveRecord::Base

	monetize :amount_cents
	
	belongs_to :individual
	belongs_to :portfolio
	
end
