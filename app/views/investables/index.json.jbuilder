json.array!(@investables) do |investable|
  json.extract! investable, :id, :name, :isCompany
  json.url investable_url(investable, format: :json)
end
