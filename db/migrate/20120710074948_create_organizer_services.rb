class CreateOrganizerServices < ActiveRecord::Migration
  def change
    create_table :organizer_services do |t|
      t.integer :organizer_id,  :null => false
      t.string :provider,       :null => false
      t.string :uid,            :null => false
      t.string :uname,          :null => false
      t.string :uemail,         :null => false

      t.timestamps
    end

    add_index :organizer_services, :organizer_id
    add_index :organizer_services, :provider
    add_index :organizer_services, :uid
    add_index :organizer_services, :uname
    add_index :organizer_services, :uemail
  end
end
