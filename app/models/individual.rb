class Individual < ActiveRecord::Base

	has_one :investable
	has_many :individual_company_investments, dependent: :destroy
	has_many :companies, through: :individual_company_investments
	
	monetize :cash_cents
end
