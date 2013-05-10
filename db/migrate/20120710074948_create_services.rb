class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :organizer_id,  :null => false
      t.string :provider,       :null => false
      t.string :uid,            :null => false
      t.string :uname,          :null => false
      t.string :uemail,         :null => false

      t.timestamps
    end
  end
end
