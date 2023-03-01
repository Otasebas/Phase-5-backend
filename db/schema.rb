# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_27_203123) do
  create_table "calendar_dates", force: :cascade do |t|
    t.string "date"
    t.string "name_of_event"
    t.string "start_time"
    t.string "end_time"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "calendar_date_id", null: false
    t.boolean "creator"
    t.string "attendance"
    t.integer "friend_group_id"
    t.boolean "invite_sent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_date_id"], name: "index_event_users_on_calendar_date_id"
    t.index ["friend_group_id"], name: "index_event_users_on_friend_group_id"
    t.index ["user_id"], name: "index_event_users_on_user_id"
  end

  create_table "friend_groups", force: :cascade do |t|
    t.string "group_name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_friend_groups_on_user_id"
  end

  create_table "friendrequests", force: :cascade do |t|
    t.integer "requestor_id"
    t.integer "receiver_id"
    t.boolean "friends?"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "friend_group_id", null: false
    t.boolean "joined"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_group_id"], name: "index_members_on_friend_group_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "phone_number"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
  end

  add_foreign_key "event_users", "calendar_dates"
  add_foreign_key "event_users", "friend_groups"
  add_foreign_key "event_users", "users"
  add_foreign_key "friend_groups", "users"
  add_foreign_key "members", "friend_groups"
  add_foreign_key "members", "users"
end
