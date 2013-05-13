class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string  :iso,             :limit => 2,    :null => false, :unique => true
      t.string  :printable_name,  :limit => 80,   :null => false, :unique => true
      t.string  :name,            :limit => 80,   :null => false, :unique => true
      t.string  :iso3,            :limit => 3,    :null => false, :unique => true
      t.integer :numcode,                         :null => false, :unique => true
      
      t.timestamps
    end
    
    add_index :countries, :iso
    add_index :countries, :printable_name
    add_index :countries, :name
    add_index :countries, :iso3
    add_index :countries, :numcode
  end
end

