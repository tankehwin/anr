class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name, :null => false
      t.string :state, :null => false, :default => "Tournament is not started."

      t.timestamps
    end
    execute("ALTER SEQUENCE tournaments_id_seq RESTART 90210;")
  end
end
