class Company < ActiveRecord::Base
	has_many :quotes, dependent: :destroy
	has_one :investable
end
