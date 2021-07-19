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

ActiveRecord::Schema.define(version: 2021_07_19_202335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avantages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_pour"
    t.string "image_contre"
    t.bigint "city_id", null: false
    t.index ["city_id"], name: "index_avantages_on_city_id"
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
    t.integer "tickets_count", default: 0, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "start_hour", default: "08:00"
    t.string "end_hour", default: "19:00"
    t.string "name"
    t.string "phone"
    t.string "email"
  end

  create_table "city_options", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.bigint "option_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rank"
    t.index ["city_id"], name: "index_city_options_on_city_id"
    t.index ["option_id"], name: "index_city_options_on_option_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.index ["city_id"], name: "index_contacts_on_city_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "tickets_count", default: 0
    t.integer "distance", default: 0
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.integer "tickets_distance", default: 0
    t.integer "price_cents", default: 0, null: false
    t.boolean "tour", default: false
    t.bigint "urgence_id"
    t.index ["urgence_id"], name: "index_deliveries_on_urgence_id"
    t.index ["user_id"], name: "index_deliveries_on_user_id"
  end

  create_table "delivery_books", force: :cascade do |t|
    t.bigint "delivery_id"
    t.bigint "tickets_book_id"
    t.integer "tickets", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["delivery_id"], name: "index_delivery_books_on_delivery_id"
    t.index ["tickets_book_id"], name: "index_delivery_books_on_tickets_book_id"
  end

  create_table "delivery_options", force: :cascade do |t|
    t.bigint "delivery_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "option_id", null: false
    t.index ["delivery_id"], name: "index_delivery_options_on_delivery_id"
    t.index ["option_id"], name: "index_delivery_options_on_option_id"
  end

  create_table "drops", force: :cascade do |t|
    t.bigint "delivery_id"
    t.string "address"
    t.string "start_hour"
    t.string "end_hour"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.date "date"
    t.index ["delivery_id"], name: "index_drops_on_delivery_id"
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
    t.integer "tickets", default: 0
    t.string "type"
    t.integer "max_value", default: 0
    t.string "image"
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_type"
    t.bigint "item_id"
    t.bigint "order_id"
    t.index ["item_type", "item_id"], name: "index_order_items_on_item_type_and_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status"
    t.integer "amount_cents", default: 0, null: false
    t.string "checkout_session_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pickups", force: :cascade do |t|
    t.bigint "delivery_id"
    t.string "address"
    t.string "start_hour"
    t.string "end_hour"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.date "date"
    t.index ["delivery_id"], name: "index_pickups_on_delivery_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "details"
    t.string "images"
    t.string "slug"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_services_on_city_id"
    t.index ["slug"], name: "index_services_on_slug", unique: true
  end

  create_table "tickets_books", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "remaining_tickets"
    t.bigint "book_template_id"
    t.string "status", default: "draft"
    t.integer "price_cents", default: 0, null: false
    t.index ["book_template_id"], name: "index_tickets_books_on_book_template_id"
    t.index ["user_id"], name: "index_tickets_books_on_user_id"
  end

  create_table "urgences", force: :cascade do |t|
    t.integer "range"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.boolean "tickets_book_renewal", default: true
    t.string "billing_company"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "volumes", force: :cascade do |t|
    t.integer "max_weight"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "avantages", "cities"
  add_foreign_key "city_options", "cities"
  add_foreign_key "city_options", "options"
  add_foreign_key "deliveries", "users"
  add_foreign_key "delivery_books", "deliveries"
  add_foreign_key "delivery_books", "tickets_books"
  add_foreign_key "delivery_options", "deliveries"
  add_foreign_key "delivery_options", "options"
  add_foreign_key "drops", "deliveries"
  add_foreign_key "favorite_addresses", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "pickups", "deliveries"
  add_foreign_key "tickets_books", "book_templates"
  add_foreign_key "tickets_books", "users"
  add_foreign_key "user_options", "options"
  add_foreign_key "user_options", "users"
end
