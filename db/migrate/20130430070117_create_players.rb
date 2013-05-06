class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :username, :null => false
      t.string :email
      t.string :name, :null => false
      t.integer :points, :null => false, :default => 0
      t.integer :matches, :null => false, :default => 0

      t.timestamps
    end
    Player.create({:id => 1, :username => "MY00001", :email => "admin@sentulasia.com", :name => "Bye"}, :as => :seed)
    execute("ALTER SEQUENCE players_id_seq RESTART 90210;")
    add_index :players, :username, :unique => true
    add_index :players, :points
    add_index :players, :matches
  end
end
