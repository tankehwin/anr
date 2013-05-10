class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name, :null => false
      t.string :state, :null => false, :default => "Tournament is not started."
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end
    add_index :tournaments, :active
  end
end
