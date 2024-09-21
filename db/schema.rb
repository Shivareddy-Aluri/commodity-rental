# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_21_103635) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commodities", force: :cascade do |t|
    t.bigint "lender_id", null: false
    t.string "category"
    t.string "name"
    t.boolean "is_rented"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lender_id"], name: "index_commodities_on_lender_id"
  end

  create_table "listings", force: :cascade do |t|
    t.bigint "commodity_id", null: false
    t.bigint "lender_id", null: false
    t.decimal "min_monthly_rate"
    t.integer "lease_period"
    t.string "bid_strategy"
    t.boolean "is_active"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commodity_id"], name: "index_listings_on_commodity_id"
    t.index ["lender_id"], name: "index_listings_on_lender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_type"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "commodities", "users", column: "lender_id"
  add_foreign_key "listings", "commodities"
  add_foreign_key "listings", "users", column: "lender_id"
end
