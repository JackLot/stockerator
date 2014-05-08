class IndividualSnapshot < ActiveRecord::Base

	has_one :individual
	monetize :amount_cents

end
