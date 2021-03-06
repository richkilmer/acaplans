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

ActiveRecord::Schema.define(version: 20131023153244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plans", force: true do |t|
    t.integer  "fips"
    t.string   "state"
    t.string   "county"
    t.integer  "level"
    t.string   "issuer"
    t.string   "name"
    t.string   "plan_type"
    t.string   "rating_area"
    t.decimal  "premium_adult_individual_27",  precision: 8, scale: 2
    t.decimal  "premium_adult_individual_50",  precision: 8, scale: 2
    t.decimal  "premium_family",               precision: 8, scale: 2
    t.decimal  "premium_single_parent_family", precision: 8, scale: 2
    t.decimal  "premium_couple",               precision: 8, scale: 2
    t.decimal  "premium_child",                precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plans", ["fips"], name: "index_plans_on_fips", using: :btree

  create_table "zips", force: true do |t|
    t.string   "code"
    t.integer  "fips"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zips", ["fips"], name: "index_zips_on_fips", using: :btree

end
