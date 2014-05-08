class PortfolioSnapshot < ActiveRecord::Base

	has_one :portfolio
	monetize :amount_cents

end
