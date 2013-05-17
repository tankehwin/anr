class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :tournament_id,   :null => false
      t.integer :schedule_id,     :null => false
      t.integer :participant_id,  :null => false
      t.integer :opponent_id,     :null => false
      t.integer :prestige
      t.integer :corp_game_points
      t.integer :runner_game_points
      t.float   :rating_score,    :null => false, :default => 0.0

      t.timestamps
    end
    add_index :results, :tournament_id
    add_index :results, :schedule_id
    add_index :results, :participant_id
    add_index :results, :opponent_id
    add_index :results, [:schedule_id, :participant_id], :name => "index_results_on_result_attributes", :unique => true
  end
end
