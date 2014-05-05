json.array!(@individual_portfolio_invesetments) do |individual_portfolio_invesetment|
  json.extract! individual_portfolio_invesetment, :id, :individual_id, :portfolio_id, :amount, :buy_date, :sell_date, :percentage
  json.url individual_portfolio_invesetment_url(individual_portfolio_invesetment, format: :json)
end
