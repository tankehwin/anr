class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name, :null => false
      t.string :state, :null => false, :default => "Tournament is not started."
      t.boolean :active, :null => false, :default => true
      t.integer :rating_multiplier, :null => false, :default => 1

      t.timestamps
    end
    add_index :tournaments, :active
  end
end
