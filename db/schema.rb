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

ActiveRecord::Schema.define(version: 20150916071552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_devices", force: true do |t|
    t.string   "remote_notification_token", limit: 256, null: false
    t.boolean  "is_ios"
    t.decimal  "last_location_latitude",                null: false
    t.decimal  "last_location_longitude",               null: false
    t.string   "dev_uuid",                  limit: 64,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publication_reports", force: true do |t|
    t.integer  "publication_id",                    null: false
    t.integer  "publication_version",               null: false
    t.integer  "report"
    t.string   "active_device_dev_uuid", limit: 64, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "date_of_report"
  end

  create_table "publications", force: true do |t|
    t.integer  "version",                            null: false
    t.string   "title",                  limit: 200, null: false
    t.text     "subtitle"
    t.string   "address",                limit: 100, null: false
    t.integer  "type_of_collecting"
    t.decimal  "latitude",                           null: false
    t.decimal  "longitude",                          null: false
    t.decimal  "starting_date"
    t.decimal  "ending_date",                        null: false
    t.string   "contact_info",           limit: 100
    t.boolean  "is_on_air"
    t.string   "active_device_dev_uuid", limit: 64,  null: false
    t.string   "photo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registered_user_for_publications", force: true do |t|
    t.integer  "publication_id",                    null: false
    t.string   "active_device_dev_uuid", limit: 64, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publication_version"
    t.decimal  "date_of_registration"
  end

end
