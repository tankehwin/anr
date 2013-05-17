class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :round_id,	:null => false
      t.integer :table,		:null => false

      t.timestamps
    end
    add_index :schedules, :round_id
    add_index :schedules, [:round_id, :table], :name => "index_schedules_on_schedule_attributes", :unique => true
  end
end
