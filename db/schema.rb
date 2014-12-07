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

ActiveRecord::Schema.define(version: 20141127203947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_devices", force: true do |t|
    t.string   "remote_notification_token"
    t.boolean  "is_ios"
    t.decimal  "last_location_latitude"
    t.decimal  "last_location_longitude"
    t.string   "device_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publication_reports", force: true do |t|
    t.integer  "publication_unique_id"
    t.integer  "publication_version"
    t.integer  "report"
    t.date     "date_of_report"
    t.string   "reporting_device_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", force: true do |t|
    t.integer  "publication_version"
    t.text     "publication_title"
    t.text     "publication_address"
    t.integer  "publication_type_of_collecting"
    t.decimal  "publication_latitude"
    t.decimal  "publication_longitude"
    t.datetime "publication_starting_date"
    t.datetime "publication_ending_date"
    t.text     "publication_contact_info"
    t.boolean  "is_on_air"
    t.text     "reporting_device_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registered_user_for_publications", force: true do |t|
    t.integer  "publication_unique_id"
    t.datetime "date_of_registration"
    t.string   "device_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
