class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :tournament_id, :null => false
      t.integer :schedule_id, :null => false
      t.integer :participant_id, :null => false
      t.integer :opponent_id, :null => false
      t.integer :prestige
      t.integer :corp_match_points
      t.integer :runner_match_points

      t.timestamps
    end
    execute("ALTER SEQUENCE results_id_seq RESTART 90210;")
    add_index :results, :tournament_id
    add_index :results, :schedule_id
    add_index :results, :participant_id
    add_index :results, :opponent_id
    add_index :results, [:schedule_id, :participant_id], :name => "index_results_on_result_attributes", :unique => true
  end
end
