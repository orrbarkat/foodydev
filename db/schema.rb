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

ActiveRecord::Schema.define(version: 20160218120345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_devices", force: :cascade do |t|
    t.string   "remote_notification_token", limit: 256, null: false
    t.boolean  "is_ios"
    t.decimal  "last_location_latitude",                null: false
    t.decimal  "last_location_longitude",               null: false
    t.string   "dev_uuid",                  limit: 64,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.string   "active_device_dev_uuid",                                 null: false
    t.string   "reporter_name",          limit: 100, default: "no_name"
    t.string   "report",                 limit: 500,                     null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  create_table "group_members", force: :cascade do |t|
    t.integer  "Group_id"
    t.integer  "user_id",      default: 0
    t.string   "phone_number"
    t.string   "name",                     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.boolean  "is_admin"
  end

  add_index "group_members", ["Group_id"], name: "index_group_members_on_Group_id", using: :btree
  add_index "group_members", ["user_id"], name: "index_group_members_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "publication_reports", force: :cascade do |t|
    t.integer  "publication_id",                    null: false
    t.integer  "publication_version",               null: false
    t.integer  "report"
    t.string   "active_device_dev_uuid", limit: 64, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "date_of_report"
    t.string   "report_user_name"
    t.string   "report_contact_info"
    t.integer  "reporter_user_id"
  end

  create_table "publications", force: :cascade do |t|
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
    t.string   "photo_url",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publisher_id"
    t.integer  "audience"
  end

  create_table "registered_user_for_publications", force: :cascade do |t|
    t.integer  "publication_id",                                  null: false
    t.string   "active_device_dev_uuid", limit: 64,               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publication_version"
    t.decimal  "date_of_registration"
    t.string   "collector_contact_info", limit: 100, default: "", null: false
    t.string   "collector_name",         limit: 100, default: "", null: false
    t.integer  "collector_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "identity_provider"
    t.string   "identity_provider_user_id"
    t.string   "identity_provider_token",                    null: false
    t.string   "phone_number",                               null: false
    t.string   "identity_provider_email",                    null: false
    t.string   "identity_provider_user_name",                null: false
    t.boolean  "is_logged_in",                default: true
    t.string   "active_device_dev_uuid",                     null: false
    t.integer  "ratings"
    t.float    "cradits",                     default: 0.0
    t.integer  "foodies",                     default: 0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

end
