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

ActiveRecord::Schema.define(version: 2020_04_21_163720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avantages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_pour"
    t.string "image_contre"
  end

  create_table "bikes", force: :cascade do |t|
    t.integer "max_weight"
    t.integer "max_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carnet_templates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ticket_nb"
    t.integer "ticket_price"
  end

  create_table "carnets", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "remaining_tickets"
    t.bigint "carnet_template_id"
    t.index ["carnet_template_id"], name: "index_carnets_on_carnet_template_id"
    t.index ["user_id"], name: "index_carnets_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "carnet_id"
    t.bigint "bike_id"
    t.integer "ticket_nb"
    t.integer "distance"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "tickets_urgence"
    t.integer "tickets_volume"
    t.integer "tickets_distance"
    t.index ["bike_id"], name: "index_courses_on_bike_id"
    t.index ["carnet_id"], name: "index_courses_on_carnet_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "drops", force: :cascade do |t|
    t.bigint "course_id"
    t.string "address"
    t.integer "start_hour"
    t.integer "end_hour"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.float "latitude"
    t.float "longitude"
    t.index ["course_id"], name: "index_drops_on_course_id"
  end

  create_table "pickups", force: :cascade do |t|
    t.bigint "course_id"
    t.string "address"
    t.integer "start_hour"
    t.integer "end_hour"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.float "latitude"
    t.float "longitude"
    t.index ["course_id"], name: "index_pickups_on_course_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "details"
    t.string "images"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "phone"
    t.string "company"
    t.string "address"
    t.string "billing_address"
    t.boolean "paper_invoice"
    t.boolean "admin", default: false
    t.integer "pool", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "carnets", "carnet_templates"
  add_foreign_key "carnets", "users"
  add_foreign_key "courses", "bikes"
  add_foreign_key "courses", "carnets"
  add_foreign_key "courses", "users"
  add_foreign_key "drops", "courses"
  add_foreign_key "pickups", "courses"
end
