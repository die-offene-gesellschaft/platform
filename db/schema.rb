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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160920183732) do

  create_table "active_members", force: :cascade do |t|
    t.string   "forename"
    t.string   "surname"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_members_events", id: false, force: :cascade do |t|
    t.integer "active_member_id", null: false
    t.integer "event_id",         null: false
    t.index ["active_member_id", "event_id"], name: "index_active_members_events_on_active_member_id_and_event_id"
    t.index ["event_id", "active_member_id"], name: "index_active_members_events_on_event_id_and_active_member_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "blogposts", force: :cascade do |t|
    t.string   "title"
    t.string   "blogpost_type"
    t.text     "introduction"
    t.text     "content"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "hero_file_name"
    t.string   "hero_content_type"
    t.integer  "hero_file_size"
    t.datetime "hero_updated_at"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.integer  "admin_id"
    t.index ["admin_id"], name: "index_blogposts_on_admin_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "message"
    t.boolean  "locked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "event_id"
    t.index ["event_id"], name: "index_comments_on_event_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string   "controller_action_name"
    t.string   "key"
    t.text     "value"
    t.integer  "order"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "event_participations", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
    t.index ["event_id", "user_id"], name: "index_event_participations_on_event_id_and_user_id"
    t.index ["user_id", "event_id"], name: "index_event_participations_on_user_id_and_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "event_type"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.text     "description"
    t.string   "facebook_identifier"
    t.boolean  "locked"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "user_id"
    t.integer  "venue_id"
    t.string   "link"
    t.boolean  "planned"
    t.text     "post_description"
    t.string   "post_description_source"
    t.index ["user_id"], name: "index_events_on_user_id"
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id"
  end

  create_table "locations", force: :cascade do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.decimal  "radius"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.text     "description"
    t.datetime "taken_at"
    t.boolean  "locked"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "event_id"
    t.integer  "user_id"
    t.index ["event_id"], name: "index_pictures_on_event_id"
    t.index ["user_id"], name: "index_pictures_on_user_id"
  end

  create_table "press_reviews", force: :cascade do |t|
    t.string   "source_url"
    t.string   "source_title"
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "event_id"
    t.index ["event_id"], name: "index_press_reviews_on_event_id"
  end

  create_table "statements", force: :cascade do |t|
    t.string   "question"
    t.string   "content"
    t.string   "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
    t.index ["event_id"], name: "index_statements_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "role"
    t.string   "statement"
    t.boolean  "locked"
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "street"
    t.string   "zip_code"
    t.string   "city"
    t.text     "description"
    t.boolean  "locked"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id"
    t.index ["location_id"], name: "index_venues_on_location_id"
  end

end
