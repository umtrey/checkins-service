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

ActiveRecord::Schema.define(version: 20140620191312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checkin_fraud_alerts", force: true do |t|
    t.integer  "checkin_id",  null: false
    t.integer  "fraud_alert", null: false
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkins", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "location_id", null: false
    t.datetime "created_at"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "source"
  end

  add_index "checkins", ["location_id"], name: "index_checkins_on_location_id", using: :btree
  add_index "checkins", ["user_id"], name: "index_checkins_on_user_id", using: :btree

  create_table "locations", force: true do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
  end

end
