json.array!(@individual_portfolio_investments) do |individual_portfolio_investment|
  json.extract! individual_portfolio_investment, :id, :individual_id, :portfolio_id, :amount, :buy_date, :sell_date, :percentage
  json.url individual_portfolio_investment_url(individual_portfolio_investment, format: :json)
end
