json.array!(@portfolios) do |portfolio|
  json.extract! portfolio, :id, :name, :isIndividual, :investable_id, :cash
  json.url portfolio_url(portfolio, format: :json)
end
