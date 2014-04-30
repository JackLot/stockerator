class FundCompanyInvestment < ActiveRecord::Base

	monetize :amount_cents
	
	belongs_to :portfolio
	belongs_to :company

end
