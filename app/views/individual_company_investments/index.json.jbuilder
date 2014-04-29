json.array!(@individual_company_investments) do |individual_company_investment|
  json.extract! individual_company_investment, :id, :individual_id, :company_id, :amount, :buy_date, :sell_date
  json.url individual_company_investment_url(individual_company_investment, format: :json)
end
