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

ActiveRecord::Schema.define(version: 2020_07_01_050426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_comments", force: :cascade do |t|
    t.text "event_comment_content"
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_comments_on_event_id"
    t.index ["user_id"], name: "index_event_comments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "event_date"
    t.string "event_title", default: "", null: false
    t.text "event_content", default: "", null: false
    t.integer "minimum_number_of_participant", null: false
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "following_id"], name: "index_friendships_on_follower_id_and_following_id", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "visitor_id", null: false
    t.bigint "visited_id", null: false
    t.bigint "practice_diary_id"
    t.bigint "practice_comment_id"
    t.string "action", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practice_comment_id"], name: "index_notifications_on_practice_comment_id"
    t.index ["practice_diary_id"], name: "index_notifications_on_practice_diary_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "participant_managements", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_participant_managements_on_event_id"
    t.index ["user_id", "event_id"], name: "index_participant_managements_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_participant_managements_on_user_id"
  end

  create_table "practice_comments", force: :cascade do |t|
    t.text "practice_comment_content"
    t.bigint "practice_diary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["practice_diary_id"], name: "index_practice_comments_on_practice_diary_id"
    t.index ["user_id"], name: "index_practice_comments_on_user_id"
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

  add_foreign_key "event_comments", "events"
  add_foreign_key "event_comments", "users"
  add_foreign_key "events", "users"
  add_foreign_key "notifications", "practice_comments"
  add_foreign_key "notifications", "practice_diaries"
  add_foreign_key "notifications", "users", column: "visited_id"
  add_foreign_key "notifications", "users", column: "visitor_id"
  add_foreign_key "participant_managements", "events"
  add_foreign_key "participant_managements", "users"
  add_foreign_key "practice_comments", "practice_diaries"
  add_foreign_key "practice_comments", "users"
  add_foreign_key "practice_diaries", "users"
  add_foreign_key "practice_favorites", "practice_diaries"
  add_foreign_key "practice_favorites", "users"
end
