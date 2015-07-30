# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150729150634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address"
    t.string   "number",       limit: 10
    t.string   "zipcode",      limit: 9
    t.string   "neighborhood", limit: 128
    t.string   "city",         limit: 128
    t.string   "state",        limit: 128
    t.string   "complement",   limit: 128
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "person_id"
  end

  add_index "addresses", ["person_id"], name: "index_addresses_on_person_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.text     "answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "donations", force: :cascade do |t|
    t.string   "title",       limit: 60
    t.text     "description"
    t.string   "situation",   limit: 20
    t.string   "status",      limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "person_id"
    t.integer  "category_id"
  end

  add_index "donations", ["category_id"], name: "index_donations_on_category_id", using: :btree
  add_index "donations", ["person_id"], name: "index_donations_on_person_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "status",       limit: 1
    t.string   "user_name",    limit: 50
    t.integer  "ranking"
    t.string   "name",         limit: 100
    t.string   "cpf",          limit: 15
    t.string   "rg",           limit: 15
    t.datetime "birth_date"
    t.string   "company_name", limit: 128
    t.string   "trading_name", limit: 128
    t.string   "cnpj",         limit: 18
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
  end

  add_index "people", ["user_id"], name: "index_people_on_user_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "person_id"
  end

  add_index "phones", ["person_id"], name: "index_phones_on_person_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "donation_id"
  end

  add_index "photos", ["donation_id"], name: "index_photos_on_donation_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "question"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "person_id"
    t.integer  "donation_id"
  end

  add_index "questions", ["donation_id"], name: "index_questions_on_donation_id", using: :btree
  add_index "questions", ["person_id"], name: "index_questions_on_person_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "des_type",               limit: 1
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
