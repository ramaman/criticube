json.id objekt.id
json.tipe objekt.class.to_s
json.name objekt.name
json.url objekt.permalink
if user_signed_in?
  json.followed current_user.is_following?(objekt)
  json.follow_link objekt.follow_permalink  
else
  json.follow_link new_user_session_path
end