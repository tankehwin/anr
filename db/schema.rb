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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130430073622) do

  create_table "participants", :force => true do |t|
    t.integer  "tournament_id",                    :null => false
    t.integer  "player_id",                        :null => false
    t.integer  "place",         :default => 0,     :null => false
    t.integer  "prestiges",     :default => 0,     :null => false
    t.integer  "match_points",  :default => 0,     :null => false
    t.integer  "matches",       :default => 0,     :null => false
    t.float    "pmw",           :default => 0.0,   :null => false
    t.float    "omw",           :default => 0.0,   :null => false
    t.float    "pgw",           :default => 0.0,   :null => false
    t.float    "ogw",           :default => 0.0,   :null => false
    t.boolean  "active",        :default => false, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "participants", ["active"], :name => "index_participants_on_active"
  add_index "participants", ["place"], :name => "index_participants_on_place"
  add_index "participants", ["tournament_id", "player_id"], :name => "index_participants_on_participant_attributes", :unique => true
  add_index "participants", ["tournament_id"], :name => "index_participants_on_tournament_id"

  create_table "players", :force => true do |t|
    t.string   "username",                       :null => false
    t.string   "email",                          :null => false
    t.string   "name",                           :null => false
    t.integer  "prestiges",    :default => 0,    :null => false
    t.integer  "match_points", :default => 0,    :null => false
    t.integer  "matches",      :default => 0,    :null => false
    t.integer  "tournaments",  :default => 0,    :null => false
    t.boolean  "active",       :default => true, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "players", ["active"], :name => "index_players_on_active"
  add_index "players", ["match_points"], :name => "index_players_on_match_points"
  add_index "players", ["matches"], :name => "index_players_on_matches"
  add_index "players", ["prestiges"], :name => "index_players_on_prestiges"
  add_index "players", ["tournaments"], :name => "index_players_on_tournaments"
  add_index "players", ["username"], :name => "index_players_on_username", :unique => true

  create_table "results", :force => true do |t|
    t.integer  "tournament_id",       :null => false
    t.integer  "schedule_id",         :null => false
    t.integer  "participant_id",      :null => false
    t.integer  "opponent_id",         :null => false
    t.integer  "prestige"
    t.integer  "corp_match_points"
    t.integer  "runner_match_points"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "results", ["opponent_id"], :name => "index_results_on_opponent_id"
  add_index "results", ["participant_id"], :name => "index_results_on_participant_id"
  add_index "results", ["schedule_id", "participant_id"], :name => "index_results_on_result_attributes", :unique => true
  add_index "results", ["schedule_id"], :name => "index_results_on_schedule_id"
  add_index "results", ["tournament_id"], :name => "index_results_on_tournament_id"

  create_table "rounds", :force => true do |t|
    t.integer  "tournament_id",                          :null => false
    t.integer  "number",                                 :null => false
    t.datetime "start"
    t.datetime "end"
    t.string   "state",         :default => "Not Ready", :null => false
    t.string   "action",        :default => "Pre-Round", :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "rounds", ["tournament_id", "number"], :name => "index_rounds_on_round_attributes", :unique => true
  add_index "rounds", ["tournament_id"], :name => "index_rounds_on_tournament_id"

  create_table "schedules", :force => true do |t|
    t.integer  "round_id",   :null => false
    t.integer  "table",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "schedules", ["round_id", "table"], :name => "index_schedules_on_schedule_attributes", :unique => true
  add_index "schedules", ["round_id"], :name => "index_schedules_on_round_id"

  create_table "tournaments", :force => true do |t|
    t.string   "name",                                                 :null => false
    t.string   "state",      :default => "Tournament is not started.", :null => false
    t.boolean  "active",     :default => true,                         :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "tournaments", ["active"], :name => "index_tournaments_on_active"

end
