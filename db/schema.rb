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

ActiveRecord::Schema.define(version: 2020_05_04_133449) do

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
    t.string "image"
    t.string "description"
    t.integer "price_cents", default: 0, null: false
  end

  create_table "carnets", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "remaining_tickets"
    t.bigint "carnet_template_id"
    t.integer "course_overflow", default: 0
    t.bigint "shopping_cart_id"
    t.index ["carnet_template_id"], name: "index_carnets_on_carnet_template_id"
    t.index ["shopping_cart_id"], name: "index_carnets_on_shopping_cart_id"
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
    t.integer "ticket_overflow", default: 0
    t.bigint "shopping_cart_id"
    t.index ["bike_id"], name: "index_courses_on_bike_id"
    t.index ["carnet_id"], name: "index_courses_on_carnet_id"
    t.index ["shopping_cart_id"], name: "index_courses_on_shopping_cart_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "drops", force: :cascade do |t|
    t.bigint "course_id"
    t.string "address"
    t.float "start_hour"
    t.float "end_hour"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.date "date"
    t.index ["course_id"], name: "index_drops_on_course_id"
  end

  create_table "favorite_addresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "details"
    t.integer "start_hour"
    t.integer "end_hour"
    t.string "title"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_favorite_addresses_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.integer "amount_cents", default: 0, null: false
    t.string "checkout_session_id"
    t.bigint "user_id"
    t.bigint "shopping_cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopping_cart_id"], name: "index_orders_on_shopping_cart_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pickups", force: :cascade do |t|
    t.bigint "course_id"
    t.string "address"
    t.float "start_hour"
    t.float "end_hour"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.date "date"
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

  create_table "shopping_carts", force: :cascade do |t|
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "state", default: "pending"
    t.index ["user_id"], name: "index_shopping_carts_on_user_id"
  end

  create_table "user_facturations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "facturation_address"
    t.string "facturation_company"
    t.string "facturation_first_name"
    t.string "facturation_last_name"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_user_facturations_on_user_id"
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
    t.boolean "paper_invoice", default: false
    t.boolean "admin", default: false
    t.integer "pool", default: 0
    t.boolean "carnet_renewal", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "carnets", "carnet_templates"
  add_foreign_key "carnets", "shopping_carts"
  add_foreign_key "carnets", "users"
  add_foreign_key "courses", "bikes"
  add_foreign_key "courses", "carnets"
  add_foreign_key "courses", "shopping_carts"
  add_foreign_key "courses", "users"
  add_foreign_key "drops", "courses"
  add_foreign_key "favorite_addresses", "users"
  add_foreign_key "orders", "shopping_carts"
  add_foreign_key "orders", "users"
  add_foreign_key "pickups", "courses"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "user_facturations", "users"
end
