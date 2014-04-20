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

ActiveRecord::Schema.define(version: 20140420172104) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "investable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investables", force: true do |t|
    t.string   "name"
    t.boolean  "isCompany",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: true do |t|
    t.date     "date"
    t.decimal  "price"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
