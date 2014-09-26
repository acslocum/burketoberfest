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

ActiveRecord::Schema.define(version: 20140926104447) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "rule1"
    t.string   "rule2"
    t.string   "rule3"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.integer  "players"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scoreType"
    t.integer  "fixedAmount"
    t.integer  "scoreCap"
    t.integer  "everybodyWins"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "rank"
    t.integer  "points"
    t.integer  "game_id"
    t.integer  "person_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["event_id"], name: "index_scores_on_event_id"
  add_index "scores", ["game_id"], name: "index_scores_on_game_id"
  add_index "scores", ["person_id"], name: "index_scores_on_person_id"

end
