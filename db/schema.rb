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

ActiveRecord::Schema.define(version: 20161128122944) do

  create_table "active_members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "forename"
    t.string   "surname"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_members_events", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "active_member_id", null: false
    t.integer "event_id",         null: false
    t.index ["active_member_id", "event_id"], name: "index_active_members_events_on_active_member_id_and_event_id", using: :btree
    t.index ["event_id", "active_member_id"], name: "index_active_members_events_on_event_id_and_active_member_id", using: :btree
  end

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "blogposts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "blogpost_type"
    t.text     "introduction",           limit: 65535
    t.text     "content",                limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "hero_file_name"
    t.string   "hero_content_type"
    t.integer  "hero_file_size"
    t.datetime "hero_updated_at"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.string   "reference"
    t.datetime "date"
    t.boolean  "published"
    t.string   "author"
    t.string   "slug"
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "message",    limit: 65535
    t.boolean  "locked"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.integer  "event_id"
    t.index ["event_id"], name: "index_comments_on_event_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "contents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "controller_action_name"
    t.string   "key"
    t.text     "value",                  limit: 65535
    t.integer  "order"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "event_participations", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
    t.index ["event_id", "user_id"], name: "index_event_participations_on_event_id_and_user_id", using: :btree
    t.index ["user_id", "event_id"], name: "index_event_participations_on_user_id_and_event_id", using: :btree
  end

  create_table "event_proposals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "subject",                 limit: 65535
    t.string   "venue"
    t.string   "date"
    t.string   "organizer"
    t.string   "contact_person_forename"
    t.string   "contact_person_surname"
    t.string   "contact_person_mail"
    t.string   "contact_person_phone"
    t.string   "participants"
    t.text     "symbol_for_open_society", limit: 65535
    t.boolean  "terms_of_use"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "event_type"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.text     "description",             limit: 65535
    t.string   "facebook_identifier"
    t.boolean  "locked"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "user_id"
    t.integer  "venue_id"
    t.text     "link",                    limit: 65535
    t.boolean  "planned"
    t.text     "post_description",        limit: 65535
    t.string   "post_description_source"
    t.string   "color"
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
    t.index ["venue_id"], name: "index_events_on_venue_id", using: :btree
  end

  create_table "events_organizers", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id",     null: false
    t.integer "organizer_id", null: false
    t.index ["event_id", "organizer_id"], name: "index_events_organizers_on_event_id_and_organizer_id", using: :btree
    t.index ["organizer_id", "event_id"], name: "index_events_organizers_on_organizer_id_and_event_id", using: :btree
  end

  create_table "friendships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", using: :btree
  end

  create_table "ideas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "subject",        limit: 65535
    t.text     "time",           limit: 65535
    t.text     "location",       limit: 65535
    t.string   "contact_person"
    t.string   "organisation"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "latitude",   precision: 10
    t.decimal  "longitude",  precision: 10
    t.decimal  "radius",     precision: 10
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "organizers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "pictures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "description",          limit: 65535
    t.datetime "taken_at"
    t.boolean  "locked"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "event_id"
    t.integer  "user_id"
    t.index ["event_id"], name: "index_pictures_on_event_id", using: :btree
    t.index ["user_id"], name: "index_pictures_on_user_id", using: :btree
  end

  create_table "press_reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "source_url"
    t.string   "source_title"
    t.string   "title"
    t.text     "description",  limit: 65535
    t.string   "link"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "event_id"
    t.index ["event_id"], name: "index_press_reviews_on_event_id", using: :btree
  end

  create_table "slides", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "link"
    t.text     "text1",                limit: 65535
    t.text     "text2",                limit: 65535
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "slide_mode",                         null: false
    t.integer  "order"
  end

  create_table "statements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "question"
    t.text     "content",    limit: 65535
    t.string   "author"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "event_id"
    t.index ["event_id"], name: "index_statements_on_event_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "role"
    t.string   "statement"
    t.boolean  "locked"
    t.string   "forename"
    t.string   "surname"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "newsletter",             default: false
    t.boolean  "terms_of_use",           default: false
    t.string   "video_url"
    t.boolean  "vip"
    t.boolean  "good_photo"
    t.boolean  "good_statement"
    t.boolean  "contributor"
    t.boolean  "frontpage"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "venues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "street"
    t.string   "zip_code"
    t.string   "city"
    t.text     "description", limit: 65535
    t.boolean  "locked"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "location_id"
    t.index ["location_id"], name: "index_venues_on_location_id", using: :btree
  end

  add_foreign_key "active_members_events", "active_members"
  add_foreign_key "active_members_events", "events"
  add_foreign_key "comments", "events"
  add_foreign_key "comments", "users"
  add_foreign_key "event_participations", "events"
  add_foreign_key "event_participations", "users"
  add_foreign_key "events", "users"
  add_foreign_key "events", "venues"
  add_foreign_key "events_organizers", "events"
  add_foreign_key "events_organizers", "organizers"
  add_foreign_key "pictures", "events"
  add_foreign_key "pictures", "users"
  add_foreign_key "press_reviews", "events"
  add_foreign_key "statements", "events"
  add_foreign_key "venues", "locations"
end
