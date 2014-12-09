json.array!(@users) do |user|
  json.extract! user, :id, :name, :site, :token
  json.url user_url(user, format: :json)
end
