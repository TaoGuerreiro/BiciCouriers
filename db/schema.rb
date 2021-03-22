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

ActiveRecord::Schema.define(version: 2021_03_22_222704) do

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

  create_table "book_templates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "description"
    t.integer "price_cents", default: 0, null: false
    t.integer "max_distance", default: 0
  end

  create_table "books", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "remaining_tickets"
    t.bigint "book_templates_id"
    t.bigint "order_items"
    t.string "status", default: "draft"
    t.integer "price_cents", default: 0, null: false
    t.index ["book_templates_id"], name: "index_books_on_book_templates_id"
    t.index ["order_items"], name: "index_books_on_order_items"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "start_hour", default: "08:00"
    t.string "end_hour", default: "19:00"
    t.integer "cargo_nb", default: 1
    t.float "distance_per_ticket", default: 3500.0
    t.integer "urgence_one_size", default: 2700
    t.integer "urgence_two_size", default: 14400
    t.string "name"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_options", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "option_id"
    t.index ["course_id"], name: "index_course_options_on_course_id"
    t.index ["option_id"], name: "index_course_options_on_option_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "tickets_count", default: 0
    t.integer "distance"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.integer "tickets_distance", default: 0
    t.integer "price_cents", default: 0, null: false
    t.boolean "tour", default: false
    t.index ["user_id"], name: "index_deliveries_on_user_id"
  end

  create_table "drops", force: :cascade do |t|
    t.bigint "course_id"
    t.string "address"
    t.string "start_hour"
    t.string "end_hour"
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

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ticket_nb"
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
    t.string "start_hour"
    t.string "end_hour"
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
    t.string "slug"
    t.index ["slug"], name: "index_services_on_slug", unique: true
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "state", default: "pending"
    t.index ["user_id"], name: "index_shopping_carts_on_user_id"
  end

  create_table "user_options", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_user_options_on_option_id"
    t.index ["user_id"], name: "index_user_options_on_user_id"
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
    t.string "billing_company"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "books", "book_templates", column: "book_templates_id"
  add_foreign_key "books", "shopping_carts", column: "order_items"
  add_foreign_key "books", "users"
  add_foreign_key "course_options", "deliveries", column: "course_id"
  add_foreign_key "course_options", "options"
  add_foreign_key "deliveries", "users"
  add_foreign_key "drops", "deliveries", column: "course_id"
  add_foreign_key "favorite_addresses", "users"
  add_foreign_key "orders", "shopping_carts"
  add_foreign_key "orders", "users"
  add_foreign_key "pickups", "deliveries", column: "course_id"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "user_options", "options"
  add_foreign_key "user_options", "users"
end
