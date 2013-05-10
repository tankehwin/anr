class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :country_id, :null => false, :default => 122
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :name, :null => false
      t.integer :prestiges, :null => false, :default => 0
      t.integer :match_points, :null => false, :default => 0
      t.integer :matches, :null => false, :default => 0
      t.integer :tournaments, :null => false, :default => 0
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end
    execute("ALTER SEQUENCE players_id_seq RESTART 90210;")
    add_index :players, :username, :unique => true
    add_index :players, :prestiges
    add_index :players, :match_points
    add_index :players, :matches
    add_index :players, :tournaments
    add_index :players, :active
  end
end
