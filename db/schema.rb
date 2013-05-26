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

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "name",                   :default => "",   :null => false
    t.boolean  "active",                 :default => true, :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "admins", ["authentication_token"], :name => "index_admins_on_authentication_token", :unique => true
  add_index "admins", ["confirmation_token"], :name => "index_admins_on_confirmation_token", :unique => true
  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["unlock_token"], :name => "index_admins_on_unlock_token", :unique => true

  create_table "countries", :force => true do |t|
    t.string   "iso",            :limit => 2,  :null => false
    t.string   "printable_name", :limit => 80, :null => false
    t.string   "name",           :limit => 80, :null => false
    t.string   "iso3",           :limit => 3,  :null => false
    t.integer  "numcode",                      :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "countries", ["iso"], :name => "index_countries_on_iso"
  add_index "countries", ["iso3"], :name => "index_countries_on_iso3"
  add_index "countries", ["name"], :name => "index_countries_on_name"
  add_index "countries", ["numcode"], :name => "index_countries_on_numcode"
  add_index "countries", ["printable_name"], :name => "index_countries_on_printable_name"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "organizer_services", :force => true do |t|
    t.integer  "organizer_id", :null => false
    t.string   "provider",     :null => false
    t.string   "uid",          :null => false
    t.string   "uname",        :null => false
    t.string   "uemail",       :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "organizer_services", ["organizer_id"], :name => "index_organizer_services_on_organizer_id"
  add_index "organizer_services", ["provider"], :name => "index_organizer_services_on_provider"
  add_index "organizer_services", ["uemail"], :name => "index_organizer_services_on_uemail"
  add_index "organizer_services", ["uid"], :name => "index_organizer_services_on_uid"
  add_index "organizer_services", ["uname"], :name => "index_organizer_services_on_uname"

  create_table "organizers", :force => true do |t|
    t.string   "email",                      :default => "",             :null => false
    t.string   "encrypted_password",         :default => "",             :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",            :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "username"
    t.string   "name",                       :default => "",             :null => false
    t.string   "time_zone",                  :default => "Kuala Lumpur", :null => false
    t.integer  "boost_tank_current_amount",  :default => 10,             :null => false
    t.integer  "boost_tank_full_limit",      :default => 10,             :null => false
    t.integer  "boost_limit_per_tournament", :default => 2,              :null => false
    t.boolean  "active",                     :default => true,           :null => false
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  add_index "organizers", ["authentication_token"], :name => "index_organizers_on_authentication_token", :unique => true
  add_index "organizers", ["confirmation_token"], :name => "index_organizers_on_confirmation_token", :unique => true
  add_index "organizers", ["email"], :name => "index_organizers_on_email", :unique => true
  add_index "organizers", ["reset_password_token"], :name => "index_organizers_on_reset_password_token", :unique => true
  add_index "organizers", ["unlock_token"], :name => "index_organizers_on_unlock_token", :unique => true
  add_index "organizers", ["username"], :name => "index_organizers_on_username", :unique => true

  create_table "participants", :force => true do |t|
    t.integer  "tournament_id",                         :null => false
    t.integer  "player_id",                             :null => false
    t.integer  "place",             :default => 0,      :null => false
    t.integer  "prestiges",         :default => 0,      :null => false
    t.integer  "game_points",       :default => 0,      :null => false
    t.integer  "head_to_head",      :default => 0,      :null => false
    t.integer  "prestige_strength", :default => 0,      :null => false
    t.integer  "points_strength",   :default => 0,      :null => false
    t.integer  "matches",           :default => 0,      :null => false
    t.string   "name",              :default => "",     :null => false
    t.float    "rating",            :default => 1400.0, :null => false
    t.float    "rating_scores",     :default => 0.0,    :null => false
    t.float    "pmw",               :default => 0.0,    :null => false
    t.float    "omw",               :default => 0.0,    :null => false
    t.float    "pgw",               :default => 0.0,    :null => false
    t.float    "ogw",               :default => 0.0,    :null => false
    t.boolean  "obtained_bye",      :default => false,  :null => false
    t.integer  "bye_prestiges"
    t.integer  "bye_game_points"
    t.boolean  "drop",              :default => false,  :null => false
    t.boolean  "active",            :default => false,  :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "participants", ["active"], :name => "index_participants_on_active"
  add_index "participants", ["drop"], :name => "index_participants_on_drop"
  add_index "participants", ["place"], :name => "index_participants_on_place"
  add_index "participants", ["player_id"], :name => "index_participants_on_player_id"
  add_index "participants", ["rating"], :name => "index_participants_on_rating"
  add_index "participants", ["tournament_id", "player_id"], :name => "index_participants_on_participant_attributes", :unique => true
  add_index "participants", ["tournament_id"], :name => "index_participants_on_tournament_id"

  create_table "player_services", :force => true do |t|
    t.integer  "player_id",  :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.string   "uname",      :null => false
    t.string   "uemail",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "player_services", ["player_id"], :name => "index_player_services_on_player_id"
  add_index "player_services", ["provider"], :name => "index_player_services_on_provider"
  add_index "player_services", ["uemail"], :name => "index_player_services_on_uemail"
  add_index "player_services", ["uid"], :name => "index_player_services_on_uid"
  add_index "player_services", ["uname"], :name => "index_player_services_on_uname"

  create_table "players", :force => true do |t|
    t.string   "email",                  :default => "",     :null => false
    t.string   "encrypted_password",     :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "username",               :default => "",     :null => false
    t.string   "login"
    t.string   "name",                   :default => "",     :null => false
    t.integer  "prestiges",              :default => 0,      :null => false
    t.integer  "game_points",            :default => 0,      :null => false
    t.integer  "matches",                :default => 0,      :null => false
    t.integer  "matches_with_bye",       :default => 0,      :null => false
    t.integer  "bye_prestiges",          :default => 0,      :null => false
    t.integer  "bye_game_points",        :default => 0,      :null => false
    t.integer  "tournaments",            :default => 0,      :null => false
    t.float    "rating",                 :default => 1400.0, :null => false
    t.integer  "country_id",             :default => 122,    :null => false
    t.boolean  "active",                 :default => true,   :null => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "players", ["active"], :name => "index_players_on_active"
  add_index "players", ["authentication_token"], :name => "index_players_on_authentication_token", :unique => true
  add_index "players", ["confirmation_token"], :name => "index_players_on_confirmation_token", :unique => true
  add_index "players", ["email"], :name => "index_players_on_email", :unique => true
  add_index "players", ["game_points"], :name => "index_players_on_game_points"
  add_index "players", ["login"], :name => "index_players_on_login", :unique => true
  add_index "players", ["matches"], :name => "index_players_on_matches"
  add_index "players", ["prestiges"], :name => "index_players_on_prestiges"
  add_index "players", ["rating"], :name => "index_players_on_rating"
  add_index "players", ["reset_password_token"], :name => "index_players_on_reset_password_token", :unique => true
  add_index "players", ["tournaments"], :name => "index_players_on_tournaments"
  add_index "players", ["unlock_token"], :name => "index_players_on_unlock_token", :unique => true
  add_index "players", ["username"], :name => "index_players_on_username", :unique => true

  create_table "results", :force => true do |t|
    t.integer  "tournament_id",                       :null => false
    t.integer  "schedule_id",                         :null => false
    t.integer  "participant_id",                      :null => false
    t.integer  "opponent_id",                         :null => false
    t.integer  "prestige"
    t.integer  "corp_game_points"
    t.integer  "runner_game_points"
    t.float    "rating_score",       :default => 0.0, :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "results", ["opponent_id"], :name => "index_results_on_opponent_id"
  add_index "results", ["participant_id"], :name => "index_results_on_participant_id"
  add_index "results", ["schedule_id", "participant_id"], :name => "index_results_on_result_attributes", :unique => true
  add_index "results", ["schedule_id"], :name => "index_results_on_schedule_id"
  add_index "results", ["tournament_id"], :name => "index_results_on_tournament_id"

  create_table "rounds", :force => true do |t|
    t.integer  "tournament_id",                            :null => false
    t.integer  "number",                                   :null => false
    t.datetime "start"
    t.datetime "end"
    t.string   "scheduling_type", :default => "Swiss",     :null => false
    t.string   "state",           :default => "Not Ready", :null => false
    t.string   "action",          :default => "Pre-Round", :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
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
    t.string   "organizer_id",                                                :null => false
    t.string   "name",                                                        :null => false
    t.text     "description"
    t.string   "state",             :default => "Tournament is not started.", :null => false
    t.string   "time_zone",         :default => "Kuala Lumpur",               :null => false
    t.integer  "rating_multiplier", :default => 1,                            :null => false
    t.integer  "rating_boost",      :default => 1,                            :null => false
    t.datetime "start"
    t.datetime "end"
    t.boolean  "flag",              :default => false,                        :null => false
    t.boolean  "active",            :default => true,                         :null => false
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
  end

  add_index "tournaments", ["active"], :name => "index_tournaments_on_active"
  add_index "tournaments", ["rating_multiplier"], :name => "index_tournaments_on_rating_multiplier"
  add_index "tournaments", ["state"], :name => "index_tournaments_on_state"

end
