json.array!(@users) do |json, user|
  json.extract! activity, :id, :created_at, :updated_at, :action_story
  # json.extract! user, :id, :first_name, :last_name, :page_name
end