json.array!(@quotes) do |quote|
  json.extract! quote, :id, :date, :price
  json.url quote_url(quote, format: :json)
end
