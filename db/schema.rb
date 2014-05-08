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

ActiveRecord::Schema.define(version: 20140508033351) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "investable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "strict_increasing", default: false
    t.decimal  "risk"
    t.decimal  "total_return"
    t.decimal  "annualized_ror"
    t.string   "full_name"
  end

  create_table "file_uploads", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fund_company_investments", force: true do |t|
    t.integer  "portfolio_id"
    t.integer  "company_id"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.date     "buy_date"
    t.date     "sell_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "individual_company_investments", force: true do |t|
    t.integer  "individual_id"
    t.integer  "company_id"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.date     "buy_date"
    t.date     "sell_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "individual_portfolio_investments", force: true do |t|
    t.integer  "individual_id"
    t.integer  "portfolio_id"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.date     "buy_date"
    t.date     "sell_date"
    t.decimal  "percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "individual_snapshots", force: true do |t|
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.date     "date"
    t.integer  "individual_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "individuals", force: true do |t|
    t.string   "name"
    t.integer  "cash_cents",    default: 0,     null: false
    t.string   "cash_currency", default: "USD", null: false
    t.integer  "investable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
  end

  create_table "investables", force: true do |t|
    t.string   "name"
    t.boolean  "isCompany",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "e_type",     default: 0
  end

  add_index "investables", ["name"], name: "index_investables_on_name", unique: true

  create_table "portfolio_snapshots", force: true do |t|
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.date     "date"
    t.integer  "portfolio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfolios", force: true do |t|
    t.string   "name"
    t.boolean  "isIndividual",  default: true
    t.integer  "investable_id"
    t.integer  "cash_cents",    default: 0,     null: false
    t.string   "cash_currency", default: "USD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
  end

  create_table "quotes", force: true do |t|
    t.date     "date"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "USD", null: false
    t.integer  "offset",         default: 0
  end

end
