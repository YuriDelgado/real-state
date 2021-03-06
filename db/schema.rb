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

ActiveRecord::Schema.define(version: 2021_03_02_044851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "realstates", force: :cascade do |t|
    t.string "name", limit: 128, null: false
    t.integer "category", default: 0, null: false
    t.string "street", limit: 128
    t.string "external_number", limit: 12, null: false
    t.string "internal_number"
    t.string "neighborhood", limit: 128, null: false
    t.string "city", limit: 64, null: false
    t.string "country", null: false
    t.integer "rooms", null: false
    t.decimal "bathrooms", precision: 5, scale: 2, default: "0.0", null: false
    t.string "comments", limit: 128
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
