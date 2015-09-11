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

ActiveRecord::Schema.define(version: 20150907043137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contestant_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id",                              null: false
    t.string   "name",                                  null: false
    t.string   "hurigana",                              null: false
    t.string   "image_url",                             null: false
    t.string   "age",                                   null: false
    t.string   "height",                                null: false
    t.string   "come_from",                             null: false
    t.string   "link_url"
    t.text     "comment",                               null: false
    t.integer  "votes",                     default: 0
    t.text     "thanks_comment",                        null: false
    t.string   "phone"
    t.string   "station"
    t.string   "how_know"
    t.boolean  "is_interest_in_idol_group",             null: false
    t.boolean  "is_share_with_twitter_ok",              null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "contestant_profiles", ["user_id"], name: "index_contestant_profiles_on_user_id", using: :btree

  create_table "contestant_tag_contestants", force: :cascade do |t|
    t.integer  "user_id",           null: false
    t.integer  "contestant_tag_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "contestant_tag_contestants", ["contestant_tag_id"], name: "index_contestant_tag_contestants_on_contestant_tag_id", using: :btree
  add_index "contestant_tag_contestants", ["user_id"], name: "index_contestant_tag_contestants_on_user_id", using: :btree

  create_table "contestant_tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "nickname",   null: false
    t.integer  "sex",        null: false
    t.string   "age",        null: false
    t.string   "prefecture", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                        null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "user_type",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

  add_foreign_key "contestant_profiles", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "contestant_tag_contestants", "contestant_tags", on_update: :cascade, on_delete: :cascade
  add_foreign_key "contestant_tag_contestants", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user_profiles", "users", on_update: :cascade, on_delete: :cascade
end
