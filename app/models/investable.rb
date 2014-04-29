class Investable < ActiveRecord::Base
	has_many :companies, dependent: :destroy
	has_many :portfolios, dependent: :destroy
	has_many :individuals, dependent: :destroy
end
