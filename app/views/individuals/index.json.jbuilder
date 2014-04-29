json.array!(@individuals) do |individual|
  json.extract! individual, :id, :name, :cash, :investable_id
  json.url individual_url(individual, format: :json)
end
