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

ActiveRecord::Schema.define(version: 20141126220929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "publications", force: true do |t|
    t.integer  "version",                           null: false
    t.string   "title",                 limit: 200, null: false
    t.string   "address",               limit: 100, null: false
    t.integer  "type_of_collecting"
    t.decimal  "latitude",                          null: false
    t.decimal  "longitude",                         null: false
    t.datetime "starting_date"
    t.datetime "ending_date",                       null: false
    t.string   "contact_info",          limit: 100, null: false
    t.boolean  "is_on_air"
    t.string   "reporting_device_uuid", limit: 64,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
