class Company < ActiveRecord::Base

	has_many :quotes, dependent: :destroy
	has_one :investable
	has_many :individual_company_investments, dependent: :destroy
	has_many :individuals, through: :individual_company_investments

end
