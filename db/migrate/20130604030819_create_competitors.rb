class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.integer :player_id
      t.integer :competitor_id
      t.integer :matches
      t.integer :prestiges
      t.integer :game_points
      t.float :net_rating

      t.timestamps
    end
  end
end
