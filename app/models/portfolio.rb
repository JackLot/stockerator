class Portfolio < ActiveRecord::Base
	has_one :investable
	monetize :cash_cents

	has_many :fund_company_investments, dependent: :destroy
	has_many :companies, through: :fund_company_investments

	has_many :individual_portfolio_investments, dependent: :destroy
	has_many :individuals, through: :individual_portfolio_investments

end
