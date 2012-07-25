json.array!(@users) do |json, user|
  json.extract! user, :id, :first_name, :last_name, :page_name
end