class Portfolio < ActiveRecord::Base
	has_one :investable
	monetize :cash_cents
end
