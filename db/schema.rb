# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120810144552) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.integer  "actor_id",              :null => false
    t.string   "action",                :null => false
    t.string   "primary_objekt_type",   :null => false
    t.integer  "primary_objekt_id",     :null => false
    t.string   "secondary_objekt_type"
    t.integer  "secondary_objekt_id"
    t.string   "tertiary_objekt_type"
    t.integer  "tertiary_objekt_id"
    t.boolean  "archived"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "activities", ["action"], :name => "index_activities_on_action"
  add_index "activities", ["actor_id"], :name => "index_activities_on_actor_id"
  add_index "activities", ["archived"], :name => "index_activities_on_archived"
  add_index "activities", ["created_at"], :name => "index_activities_on_created_at"
  add_index "activities", ["primary_objekt_type", "primary_objekt_id"], :name => "primary_objekt"
  add_index "activities", ["secondary_objekt_type", "secondary_objekt_id"], :name => "secondary_objekt"
  add_index "activities", ["tertiary_objekt_type", "tertiary_objekt_id"], :name => "tertiary_objekt"
  add_index "activities", ["updated_at"], :name => "index_activities_on_updated_at"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.string   "uid",              :null => false
    t.string   "provider",         :null => false
    t.string   "token"
    t.boolean  "timeline"
    t.integer  "token_expires_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "authentications", ["provider"], :name => "index_authentications_on_provider"
  add_index "authentications", ["timeline", "provider"], :name => "index_authentications_on_timeline_and_provider"
  add_index "authentications", ["uid", "provider"], :name => "index_authentications_on_uid_and_provider", :unique => true
  add_index "authentications", ["user_id", "provider"], :name => "index_authentications_on_user_id_and_provider", :unique => true
  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "cubes", :force => true do |t|
    t.string   "name"
    t.string   "tipe"
    t.text     "description"
    t.string   "language"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "page_name"
    t.string   "avatar"
    t.integer  "creator_id"
    t.boolean  "official",    :default => false
    t.boolean  "featured",    :default => false
  end

  add_index "cubes", ["creator_id", "tipe"], :name => "index_cubes_on_creator_id_and_tipe"
  add_index "cubes", ["creator_id"], :name => "index_cubes_on_creator_id"
  add_index "cubes", ["featured"], :name => "index_cubes_on_featured"
  add_index "cubes", ["language"], :name => "index_cubes_on_language"
  add_index "cubes", ["name"], :name => "index_cubes_on_name"
  add_index "cubes", ["official"], :name => "index_cubes_on_official"
  add_index "cubes", ["page_name"], :name => "index_cubes_on_page_name", :unique => true
  add_index "cubes", ["tipe"], :name => "index_cubes_on_tipe"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feedbacks", :force => true do |t|
    t.integer  "creator_id"
    t.string   "tipe"
    t.text     "content"
    t.boolean  "responded",  :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "feedbacks", ["created_at"], :name => "index_feedbacks_on_created_at"
  add_index "feedbacks", ["creator_id"], :name => "index_feedbacks_on_creator_id"
  add_index "feedbacks", ["responded"], :name => "index_feedbacks_on_responded"
  add_index "feedbacks", ["tipe", "responded"], :name => "index_feedbacks_on_tipe_and_responded"
  add_index "feedbacks", ["tipe"], :name => "index_feedbacks_on_tipe"
  add_index "feedbacks", ["updated_at"], :name => "index_feedbacks_on_updated_at"

  create_table "followages", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.string   "followed_type"
  end

  add_index "followages", ["followed_id", "followed_type"], :name => "index_followages_on_followed_id_and_followed_type"
  add_index "followages", ["follower_id", "followed_id", "followed_type"], :name => "followage_combo", :unique => true
  add_index "followages", ["follower_id"], :name => "index_followages_on_follower_id"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id",                       :null => false
    t.integer  "recipient_id",                    :null => false
    t.text     "body"
    t.boolean  "read",         :default => false, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "messages", ["created_at"], :name => "index_messages_on_created_at"
  add_index "messages", ["read", "recipient_id"], :name => "index_messages_on_read_and_recipient_id"
  add_index "messages", ["read"], :name => "index_messages_on_read"
  add_index "messages", ["recipient_id"], :name => "index_messages_on_recipient_id"
  add_index "messages", ["sender_id", "recipient_id"], :name => "index_messages_on_sender_id_and_recipient_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.boolean  "read",        :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "notifications", ["activity_id"], :name => "index_notifications_on_activity_id"
  add_index "notifications", ["user_id", "read"], :name => "index_notifications_on_user_id_and_read"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "headline",    :null => false
    t.text     "content"
    t.integer  "creator_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
    t.string   "tipe"
    t.string   "parent_type"
    t.integer  "parent_id"
  end

  add_index "posts", ["creator_id"], :name => "index_posts_on_creator_id"
  add_index "posts", ["headline"], :name => "index_posts_on_headline"
  add_index "posts", ["slug"], :name => "index_posts_on_slug", :unique => true
  add_index "posts", ["tipe", "creator_id"], :name => "index_posts_on_tipe_and_creator_id"
  add_index "posts", ["tipe", "parent_id", "parent_type"], :name => "index_posts_on_tipe_and_parent_id_and_parent_type"
  add_index "posts", ["tipe"], :name => "index_posts_on_tipe"

  create_table "replies", :force => true do |t|
    t.string   "tipe"
    t.text     "content"
    t.integer  "creator_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "container_id"
    t.string   "container_type"
    t.string   "ancestry"
  end

  add_index "replies", ["ancestry"], :name => "index_replies_on_ancestry"
  add_index "replies", ["container_id", "container_type"], :name => "index_replies_on_container_id_and_container_type"
  add_index "replies", ["content"], :name => "index_replies_on_content"
  add_index "replies", ["creator_id", "tipe"], :name => "index_replies_on_creator_id_and_tipe"
  add_index "replies", ["creator_id"], :name => "index_replies_on_creator_id"
  add_index "replies", ["tipe"], :name => "index_replies_on_tipe"

  create_table "roles", :force => true do |t|
    t.string   "tipe"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "on_type"
    t.integer  "on_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["on_id", "on_type"], :name => "index_roles_on_on_id_and_on_type"
  add_index "roles", ["owner_id", "owner_type"], :name => "index_roles_on_owner_id_and_owner_type"
  add_index "roles", ["tipe", "owner_id", "owner_type", "on_id", "on_type"], :name => "unique_participation_combo", :unique => true

  create_table "rs_evaluations", :force => true do |t|
    t.string   "reputation_name"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.float    "value",           :default => 0.0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], :name => "index_rs_evaluations_on_reputation_name_and_source_and_target"
  add_index "rs_evaluations", ["reputation_name"], :name => "index_rs_evaluations_on_reputation_name"
  add_index "rs_evaluations", ["source_id", "source_type"], :name => "index_rs_evaluations_on_source_id_and_source_type"
  add_index "rs_evaluations", ["target_id", "target_type"], :name => "index_rs_evaluations_on_target_id_and_target_type"

  create_table "rs_reputation_messages", :force => true do |t|
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.float    "weight",      :default => 1.0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_receiver_id_and_sender"
  add_index "rs_reputation_messages", ["receiver_id"], :name => "index_rs_reputation_messages_on_receiver_id"
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_sender_id_and_sender_type"

  create_table "rs_reputations", :force => true do |t|
    t.string   "reputation_name"
    t.float    "value",           :default => 0.0
    t.string   "aggregated_by"
    t.integer  "target_id"
    t.string   "target_type"
    t.boolean  "active",          :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], :name => "index_rs_reputations_on_reputation_name_and_target"
  add_index "rs_reputations", ["reputation_name"], :name => "index_rs_reputations_on_reputation_name"
  add_index "rs_reputations", ["target_id", "target_type"], :name => "index_rs_reputations_on_target_id_and_target_type"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name",                                :null => false
    t.string   "last_name",                                 :null => false
    t.text     "bio"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "middle_names"
    t.boolean  "admin"
    t.boolean  "super_admin"
    t.string   "avatar"
    t.string   "page_name"
    t.boolean  "banned"
    t.integer  "notifications_count",    :default => 0
    t.boolean  "subscribe_messages",     :default => true
    t.integer  "unread_messages_count",  :default => 0
    t.boolean  "cc_team",                :default => false
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["banned"], :name => "index_users_on_banned"
  add_index "users", ["cc_team"], :name => "index_users_on_cc_team"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["middle_names"], :name => "index_users_on_middle_names"
  add_index "users", ["page_name"], :name => "index_users_on_page_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["super_admin"], :name => "index_users_on_super_admin"

  create_table "vanities", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "owner_id",   :null => false
    t.string   "owner_type", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "vanities", ["name"], :name => "index_vanities_on_name", :unique => true
  add_index "vanities", ["owner_type", "owner_id"], :name => "index_vanities_on_owner_type_and_owner_id"
  add_index "vanities", ["owner_type"], :name => "index_vanities_on_owner_type"

end
