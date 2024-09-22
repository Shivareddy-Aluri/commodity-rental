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

ActiveRecord::Schema[7.2].define(version: 2024_09_22_100327) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.uuid "bid_id"
    t.bigint "listing_id", null: false
    t.bigint "renter_id", null: false
    t.decimal "bid_price_month"
    t.integer "lease_period"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_bids_on_listing_id"
    t.index ["renter_id"], name: "index_bids_on_renter_id"
  end

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

  create_table "rentals", force: :cascade do |t|
    t.bigint "commodity_id", null: false
    t.bigint "listing_id", null: false
    t.bigint "renter_id", null: false
    t.bigint "accepted_bid_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.decimal "monthly_rate"
    t.integer "lease_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accepted_bid_id"], name: "index_rentals_on_accepted_bid_id"
    t.index ["commodity_id"], name: "index_rentals_on_commodity_id"
    t.index ["listing_id"], name: "index_rentals_on_listing_id"
    t.index ["renter_id"], name: "index_rentals_on_renter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_type"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bids", "listings"
  add_foreign_key "bids", "users", column: "renter_id"
  add_foreign_key "commodities", "users", column: "lender_id"
  add_foreign_key "listings", "commodities"
  add_foreign_key "listings", "users", column: "lender_id"
  add_foreign_key "rentals", "bids", column: "accepted_bid_id"
  add_foreign_key "rentals", "commodities"
  add_foreign_key "rentals", "listings"
  add_foreign_key "rentals", "users", column: "renter_id"
end
