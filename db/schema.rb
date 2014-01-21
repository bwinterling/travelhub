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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140121041145) do

  create_table "checkins", force: true do |t|
    t.integer  "user_id"
    t.string   "venue_name"
    t.string   "venue_street_address"
    t.decimal  "venue_latitude",       precision: 10, scale: 6
    t.decimal  "venue_longitude",      precision: 10, scale: 6
    t.string   "shout"
    t.datetime "checkins_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkins", ["user_id"], name: "index_checkins_on_user_id"

  create_table "feed_sources", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_sources", ["user_id"], name: "index_feed_sources_on_user_id"

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.text     "photo_id"
    t.text     "thumbnail_url"
    t.text     "standard_url"
    t.text     "caption"
    t.datetime "photo_taken"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["photo_taken"], name: "index_photos_on_photo_taken"
  add_index "photos", ["user_id"], name: "index_photos_on_user_id"

  create_table "statuses", force: true do |t|
    t.string   "text"
    t.integer  "user_id"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["sent_at"], name: "index_statuses_on_sent_at"
  add_index "statuses", ["user_id"], name: "index_statuses_on_user_id"

  create_table "trip_users", force: true do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  create_table "trips", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "avatar_url"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "access_secret"
  end

end
