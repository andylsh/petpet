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

ActiveRecord::Schema.define(version: 20171019084803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animal_shelters", force: :cascade do |t|
    t.string   "company_name"
    t.string   "office_number"
    t.string   "company_address1"
    t.string   "company_address2"
    t.string   "city"
    t.string   "state"
    t.integer  "postcode"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "created_by"
  end

  create_table "pets", force: :cascade do |t|
    t.string   "name"
    t.integer  "age_year"
    t.integer  "age_month"
    t.text     "description"
    t.string   "pet_type"
    t.string   "photo"
    t.integer  "user_id"
    t.integer  "animal_shelter_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "staff_id"
    t.boolean  "verification",      default: false
    t.index ["animal_shelter_id"], name: "index_pets_on_animal_shelter_id", using: :btree
    t.index ["user_id"], name: "index_pets_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "postcode"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role",              default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "animal_shelter_id"
    t.index ["animal_shelter_id"], name: "index_users_on_animal_shelter_id", using: :btree
  end

  add_foreign_key "pets", "animal_shelters"
  add_foreign_key "pets", "users"
  add_foreign_key "users", "animal_shelters"
end
