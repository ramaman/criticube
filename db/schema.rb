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

ActiveRecord::Schema.define(:version => 20120726235120) do

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
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "page_name"
    t.string   "avatar"
  end

  add_index "cubes", ["language"], :name => "index_cubes_on_language"
  add_index "cubes", ["name"], :name => "index_cubes_on_name"
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

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name",                             :null => false
    t.string   "last_name",                              :null => false
    t.text     "bio"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "middle_names"
    t.boolean  "admin"
    t.boolean  "super_admin"
    t.string   "avatar"
    t.string   "page_name"
    t.boolean  "banned"
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["banned"], :name => "index_users_on_banned"
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
