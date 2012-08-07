json.extract! activity, :id, :created_at, :updated_at, :action_story, :primary_objekt_type

json.actor do |json|
  json.id activity.actor.id
  json.name activity.actor.fast_name
  json.url activity.actor.url
  json.avatar_url activity.actor.avatar_url(:small)
end

json.primary_objekt do |json|
  json.partial! "/activities/objekt", objekt: activity.primary_objekt
end

if activity.secondary_objekt
  json.secondary_objekt do |json|
    json.partial! "/activities/objekt", objekt: activity.secondary_objekt
  end
end

if activity.tertiary_objekt
  json.tertiary_objekt do |json|  
    json.partial! "/activities/objekt", objekt: activity.tertiary_objekt
  end
end