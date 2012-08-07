json.array!(@activities) do |json, activity|
  json.partial! "/activities/activity", activity: activity
end