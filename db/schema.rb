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

ActiveRecord::Schema.define(version: 2020_07_06_023324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "circles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "abbreviation"
  end

  create_table "decisions", force: :cascade do |t|
    t.string "name"
    t.date "date_decided"
    t.text "description"
    t.date "review_by_date"
    t.string "supp_doc_one_type"
    t.string "supp_doc_one_link"
    t.string "supp_doc_two_type"
    t.string "supp_doc_two_link"
    t.bigint "circle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circle_id"], name: "index_decisions_on_circle_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "circle_id"
    t.bigint "user_id"
    t.index ["circle_id"], name: "index_roles_on_circle_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "site_admin_type"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_initial"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
