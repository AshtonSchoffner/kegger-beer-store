# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_13_024404) do

  create_table "beers", force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.float "alcohol_vol"
    t.float "price"
    t.integer "quantity"
    t.text "description"
    t.integer "category_id", null: false
    t.integer "brewer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brewer_id"], name: "index_beers_on_brewer_id"
    t.index ["category_id"], name: "index_beers_on_category_id"
  end

  create_table "brewers", force: :cascade do |t|
    t.string "name"
    t.integer "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_brewers_on_country_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  add_foreign_key "beers", "brewers"
  add_foreign_key "beers", "categories"
  add_foreign_key "brewers", "countries"
  add_foreign_key "subcategories", "categories"
end
