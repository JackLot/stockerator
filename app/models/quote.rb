class Quote < ActiveRecord::Base
	belongs_to :company
	monetize :price_cents
end
