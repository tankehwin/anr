class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string  :organizer_id
      t.string  :name, :null => false
      t.text    :description
      t.string  :state, :null => false, :default => "Tournament is not started."
      t.integer :rating_multiplier, :null => false, :default => 1
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end

    add_index :tournaments, :state
    add_index :tournaments, :rating_multiplier
    add_index :tournaments, :active
  end
end
