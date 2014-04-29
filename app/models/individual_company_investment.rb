class IndividualCompanyInvestment < ActiveRecord::Base

	monetize :amount_cents
	
	belongs_to :individual
	belongs_to :company
end
