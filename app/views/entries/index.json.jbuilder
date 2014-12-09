json.array!(@entries) do |entry|
  json.extract! entry, :id, :entry_text
  json.url entry_url(entry, format: :json)
end
