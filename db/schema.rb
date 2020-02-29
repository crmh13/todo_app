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

ActiveRecord::Schema.define(version: 2018_08_05_020406) do

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_comments_on_task_id"
  end

  create_table "details", force: :cascade do |t|
    t.text "content"
    t.integer "status", default: 0
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_details_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.text "title"
    t.integer "status", default: 0
    t.date "completion_date"
    t.date "scheduled_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "send_mail", default: false
    t.index ["scheduled_date"], name: "index_tasks_on_scheduled_date"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.integer "tasks_count", default: 0
    t.string "avatar"
    t.string "bgimage"
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
