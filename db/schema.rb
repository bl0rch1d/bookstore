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

ActiveRecord::Schema.define(version: 20_190_702_142_636) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author_type_and_author_id'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource_type_and_resource_id'
  end

  create_table 'addresses', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'address'
    t.string 'city'
    t.string 'zip'
    t.string 'country'
    t.string 'phone'
    t.string 'addressable_type'
    t.bigint 'addressable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[addressable_type addressable_id], name: 'index_addresses_on_addressable_type_and_addressable_id'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'authors', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'authors_books', id: false, force: :cascade do |t|
    t.bigint 'book_id', null: false
    t.bigint 'author_id', null: false
    t.index %w[author_id book_id], name: 'index_authors_books_on_author_id_and_book_id'
    t.index %w[book_id author_id], name: 'index_authors_books_on_book_id_and_author_id'
  end

  create_table 'book_images', force: :cascade do |t|
    t.bigint 'book_id'
    t.string 'image'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['book_id'], name: 'index_book_images_on_book_id'
  end

  create_table 'books', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.decimal 'price', precision: 10, scale: 2
    t.integer 'quantity'
    t.string 'height'
    t.string 'width'
    t.string 'depth'
    t.integer 'year'
    t.string 'materials'
    t.bigint 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_books_on_category_id'
  end

  create_table 'books_materials', id: false, force: :cascade do |t|
    t.bigint 'material_id', null: false
    t.bigint 'book_id', null: false
    t.index %w[book_id material_id], name: 'index_books_materials_on_book_id_and_material_id'
    t.index %w[material_id book_id], name: 'index_books_materials_on_material_id_and_book_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'title'
    t.integer 'books_count'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'coupons', force: :cascade do |t|
    t.string 'code'
    t.integer 'discount'
    t.datetime 'expire_date'
    t.bigint 'order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_coupons_on_order_id'
  end

  create_table 'credit_cards', force: :cascade do |t|
    t.string 'card_name'
    t.string 'number'
    t.string 'cvv'
    t.string 'expiration_date'
    t.bigint 'order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_credit_cards_on_order_id'
  end

  create_table 'customers', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_customers_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_customers_on_reset_password_token', unique: true
  end

  create_table 'materials', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'order_items', force: :cascade do |t|
    t.decimal 'price', precision: 10, scale: 2
    t.integer 'quantity'
    t.bigint 'order_id'
    t.bigint 'book_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['book_id'], name: 'index_order_items_on_book_id'
    t.index ['order_id'], name: 'index_order_items_on_order_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.string 'number'
    t.decimal 'total_price', precision: 10, scale: 2
    t.datetime 'completed_at'
    t.string 'state'
    t.bigint 'customer_id'
    t.bigint 'shipping_method_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['customer_id'], name: 'index_orders_on_customer_id'
    t.index ['shipping_method_id'], name: 'index_orders_on_shipping_method_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.text 'body'
    t.integer 'rating'
    t.string 'state'
    t.bigint 'customer_id'
    t.bigint 'book_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['book_id'], name: 'index_reviews_on_book_id'
    t.index ['customer_id'], name: 'index_reviews_on_customer_id'
  end

  create_table 'shipping_methods', force: :cascade do |t|
    t.string 'title'
    t.integer 'min_days'
    t.integer 'max_days'
    t.decimal 'price', precision: 10, scale: 2
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'book_images', 'books'
  add_foreign_key 'coupons', 'orders'
  add_foreign_key 'credit_cards', 'orders'
  add_foreign_key 'order_items', 'books'
  add_foreign_key 'order_items', 'orders'
  add_foreign_key 'orders', 'customers'
  add_foreign_key 'orders', 'shipping_methods'
  add_foreign_key 'reviews', 'books'
  add_foreign_key 'reviews', 'customers'
end
