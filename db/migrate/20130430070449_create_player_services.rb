class CreatePlayerServices < ActiveRecord::Migration
  def change
    create_table :player_services do |t|
      t.integer :player_id,     :null => false
      t.string :provider,       :null => false
      t.string :uid,            :null => false
      t.string :uname,          :null => false
      t.string :uemail,         :null => false

      t.timestamps
    end

    add_index :player_services, :player_id
    add_index :player_services, :provider
    add_index :player_services, :uid
    add_index :player_services, :uname
    add_index :player_services, :uemail
  end
end
