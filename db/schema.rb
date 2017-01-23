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

ActiveRecord::Schema.define(version: 20170122200751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  end

  create_table "book_issues", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "consumer_id"
    t.datetime "issued_at"
    t.date     "due_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["book_id", "consumer_id"], name: "index_book_issues_on_book_id_and_consumer_id", unique: true, using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "title",                  null: false
    t.string   "author",                 null: false
    t.string   "isbn",                   null: false
    t.integer  "quantity",   default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["isbn"], name: "index_books_on_isbn", unique: true, using: :btree
  end

  create_table "consumers", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_consumers_on_email", unique: true, using: :btree
  end

end
