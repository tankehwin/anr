class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :tournament_id,   :null => false
      t.integer :player_id,       :null => false
      t.integer :place,           :null => false, :default => 0
      t.integer :prestiges,       :null => false, :default => 0
      t.integer :match_points,    :null => false, :default => 0
      t.integer :matches,         :null => false, :default => 0
      t.float   :rating,          :null => false, :default => 1400.0
      t.float   :rating_scores,   :null => false, :default => 0.0
      t.float :pmw, :null => false, :default => 0
      t.float :omw, :null => false, :default => 0
      t.float :pgw, :null => false, :default => 0
      t.float :ogw, :null => false, :default => 0
      t.boolean :active, :null => false, :default => false

      t.timestamps
    end
    add_index :participants, :tournament_id
    add_index :participants, :place
    add_index :participants, :active
    add_index :participants, [:tournament_id, :player_id], :name => "index_participants_on_participant_attributes", :unique => true
  end
end
