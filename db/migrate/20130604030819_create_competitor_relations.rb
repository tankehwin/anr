class CreateCompetitorRelations < ActiveRecord::Migration
  def change
    create_table :competitor_relations do |t|
      t.integer :player_id,     :null => false
      t.integer :competitor_id, :null => false
      t.integer :matches,       :null => false, :default => 0
      t.integer :prestiges,     :null => false, :default => 0
      t.integer :game_points,   :null => false, :default => 0
      t.float :net_rating,      :null => false, :default => 0.0

      t.timestamps
    end

    add_index :competitor_relations, :player_id
    add_index :competitor_relations, [:player_id, :competitor_id], :name => "index_competitor_relations_on_competitor_relation_attributes", :unique => true
  end
end
