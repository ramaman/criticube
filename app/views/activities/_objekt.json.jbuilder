json.id objekt.id
json.tipe objekt.class.to_s
json.name objekt.name
json.url objekt.url
if user_signed_in?
  json.followed current_user.is_following?(objekt)
  json.follow_url objekt.follow_permalink
  json.unfollow_url objekt. unfollow_permalink
else
  json.follow_url new_user_session_path
end