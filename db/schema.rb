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

ActiveRecord::Schema.define(version: 2020_06_11_002556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "practice_comments", force: :cascade do |t|
    t.text "practice_comment_content"
    t.bigint "practice_diary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practice_diary_id"], name: "index_practice_comments_on_practice_diary_id"
  end

  create_table "practice_diaries", force: :cascade do |t|
    t.date "practice_date"
    t.string "practice_title", null: false
    t.text "practice_content", null: false
    t.float "practice_distance", null: false
    t.time "practice_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_practice_diaries_on_user_id"
  end

  create_table "practice_favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "practice_diary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practice_diary_id"], name: "index_practice_favorites_on_practice_diary_id"
    t.index ["user_id", "practice_diary_id"], name: "index_practice_favorites_on_user_id_and_practice_diary_id", unique: true
    t.index ["user_id"], name: "index_practice_favorites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name", default: "", null: false
    t.text "self_introduction", default: "", null: false
    t.text "target", default: "", null: false
    t.string "image"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "practice_comments", "practice_diaries"
  add_foreign_key "practice_diaries", "users"
  add_foreign_key "practice_favorites", "practice_diaries"
  add_foreign_key "practice_favorites", "users"
end
