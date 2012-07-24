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

ActiveRecord::Schema.define(:version => 20120724153740) do

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
