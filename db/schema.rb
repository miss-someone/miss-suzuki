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

ActiveRecord::Schema.define(version: 20151112141609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "ads", force: :cascade do |t|
    t.string   "name",                                           null: false
    t.string   "image"
    t.string   "image_tmp"
    t.boolean  "is_active",                                      null: false
    t.text     "memo"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "link_url",   default: "https://miss-suzuki.com", null: false
  end

  create_table "contestant_images", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "profile_image"
    t.integer  "profile_image_crop_param_x",                     null: false
    t.integer  "profile_image_crop_param_y",                     null: false
    t.integer  "profile_image_crop_param_width",                 null: false
    t.integer  "profile_image_crop_param_height",                null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "is_pending",                      default: true, null: false
    t.string   "profile_image_tmp"
  end

  add_index "contestant_images", ["user_id"], name: "index_contestant_images_on_user_id", using: :btree

  create_table "contestant_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id",                                        null: false
    t.string   "name",                                            null: false
    t.string   "hurigana",                                        null: false
    t.string   "profile_image"
    t.string   "age"
    t.string   "height",                                          null: false
    t.string   "come_from",                                       null: false
    t.string   "link_url"
    t.text     "comment",                                         null: false
    t.integer  "votes",                           default: 0
    t.text     "thanks_comment",                                  null: false
    t.string   "phone"
    t.string   "station"
    t.string   "how_know"
    t.boolean  "is_interest_in_idol_group",                       null: false
    t.boolean  "is_share_with_twitter_ok",                        null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "profile_image_crop_param_x"
    t.integer  "profile_image_crop_param_y"
    t.integer  "profile_image_crop_param_width"
    t.integer  "profile_image_crop_param_height"
    t.integer  "link_type"
    t.boolean  "is_preopen",                      default: false, null: false
    t.string   "profile_image_crop_param_extra",  default: "",    null: false
    t.integer  "profile_image_blur_param",        default: 0,     null: false
    t.integer  "status",                          default: 0,     null: false
    t.string   "profile_image_tmp"
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

  create_table "interview_answers", force: :cascade do |t|
    t.integer  "interview_topic_id", null: false
    t.integer  "user_id",            null: false
    t.string   "answer",             null: false
    t.boolean  "is_pending",         null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "interview_answers", ["interview_topic_id"], name: "index_interview_answers_on_interview_topic_id", using: :btree
  add_index "interview_answers", ["user_id"], name: "index_interview_answers_on_user_id", using: :btree

  create_table "interview_topics", force: :cascade do |t|
    t.string   "topic",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news", force: :cascade do |t|
    t.date     "date",                         null: false
    t.boolean  "is_important", default: false
    t.text     "content",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.string   "nickname",        null: false
    t.integer  "sex",             null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "prefecture_code", null: false
    t.integer  "age_id",          null: false
    t.integer  "job_id",          null: false
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "user_type",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "voter_id"
    t.integer  "contestant_id", null: false
    t.integer  "group_id",      null: false
    t.string   "ip_address"
    t.string   "cookie_token"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "votes", ["contestant_id"], name: "index_votes_on_contestant_id", using: :btree
  add_index "votes", ["cookie_token"], name: "index_votes_on_cookie_token", using: :btree
  add_index "votes", ["ip_address"], name: "index_votes_on_ip_address", using: :btree
  add_index "votes", ["voter_id"], name: "index_votes_on_voter_id", using: :btree

  add_foreign_key "contestant_profiles", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "contestant_tag_contestants", "contestant_tags", on_update: :cascade, on_delete: :cascade
  add_foreign_key "contestant_tag_contestants", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "interview_answers", "interview_topics", on_update: :cascade, on_delete: :cascade
  add_foreign_key "interview_answers", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user_profiles", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "votes", "users", column: "contestant_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "votes", "users", column: "voter_id", on_update: :cascade, on_delete: :cascade
end
