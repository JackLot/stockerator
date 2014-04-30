json.array!(@fund_company_investments) do |fund_company_investment|
  json.extract! fund_company_investment, :id, :portfolio_id, :company_id, :amount, :buy_date, :sell_date
  json.url fund_company_investment_url(fund_company_investment, format: :json)
end
