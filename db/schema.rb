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

ActiveRecord::Schema.define(version: 2022_07_04_100636) do

  create_table "dailies", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "game_id"
    t.integer "date_progress", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id", "date_progress"], name: "index_dailies_on_game_id_and_date_progress", unique: true
    t.index ["game_id"], name: "index_dailies_on_game_id"
  end

  create_table "daily_reports", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "daily_id"
    t.bigint "executed_player_id", null: false
    t.bigint "murdered_player_id"
    t.bigint "perished_player_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["daily_id"], name: "index_daily_reports_on_daily_id"
    t.index ["executed_player_id"], name: "index_daily_reports_on_executed_player_id"
    t.index ["murdered_player_id"], name: "index_daily_reports_on_murdered_player_id"
    t.index ["perished_player_id"], name: "index_daily_reports_on_perished_player_id"
  end

  create_table "game_player_relations", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "player_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id", "player_id"], name: "index_game_player_relations_on_game_id_and_player_id", unique: true
    t.index ["game_id"], name: "index_game_player_relations_on_game_id"
    t.index ["player_id"], name: "index_game_player_relations_on_player_id"
  end

  create_table "game_roles", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_game_roles_on_game_id"
    t.index ["role_id"], name: "index_game_roles_on_role_id"
  end

  create_table "games", charset: "utf8mb4", force: :cascade do |t|
    t.string "game_name", null: false
    t.boolean "is_win"
    t.integer "date_progress"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", charset: "utf8mb4", force: :cascade do |t|
    t.string "player_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_name"], name: "index_players_on_player_name", unique: true
  end

  create_table "votes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "voter_id"
    t.bigint "voted_id"
    t.bigint "daily_id"
    t.bigint "game_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["daily_id"], name: "index_votes_on_daily_id"
    t.index ["game_id", "daily_id", "voter_id", "voted_id"], name: "index_votes_on_game_id_and_daily_id_and_voter_id_and_voted_id", unique: true
    t.index ["game_id"], name: "index_votes_on_game_id"
    t.index ["voted_id"], name: "index_votes_on_voted_id"
    t.index ["voter_id"], name: "index_votes_on_voter_id"
  end

  add_foreign_key "dailies", "games"
  add_foreign_key "daily_reports", "players", column: "executed_player_id"
  add_foreign_key "daily_reports", "players", column: "murdered_player_id"
  add_foreign_key "daily_reports", "players", column: "perished_player_id"
  add_foreign_key "votes", "dailies"
  add_foreign_key "votes", "games"
  add_foreign_key "votes", "players", column: "voted_id"
  add_foreign_key "votes", "players", column: "voter_id"
end
