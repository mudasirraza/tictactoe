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

ActiveRecord::Schema.define(version: 2021_07_19_095258) do

  create_table "games", force: :cascade do |t|
    t.text "token"
    t.string "user"
    t.string "winner"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "markers", force: :cascade do |t|
    t.integer "index_num"
    t.string "user"
    t.integer "game_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"game\", \"user\", \"index_num\"", name: "index_markers_on_game_and_user_and_index_num", unique: true
    t.index ["game_id"], name: "index_markers_on_game_id"
  end

  add_foreign_key "markers", "games"
end
