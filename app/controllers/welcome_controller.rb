class WelcomeController < ApplicationController
  def index
  	@companiesByRisk = Company.order(risk: :asc).take(5)
  	@companiesStrictlyIncreasing = Company.where(strict_increasing: true)
  	@companiesByROR = Company.order(annualized_ror: :desc).take(25)
  end
end
