class Portfolio < ActiveRecord::Base

	has_one :investable
	monetize :cash_cents
	monetize :net_worth_cents

	has_many :portfolio_snapshots

	has_many :fund_company_investments, dependent: :destroy
	has_many :companies, through: :fund_company_investments

	has_many :individual_portfolio_investments, dependent: :destroy
	has_many :individuals, through: :individual_portfolio_investments

end
