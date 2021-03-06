class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer   :tournament_id,   :null => false
      t.integer   :number,          :null => false
      t.datetime  :start
      t.datetime  :end
      t.string    :scheduling_type, :null => false, :default => "Swiss"
      t.string    :state,           :null => false, :default => "Not Ready"
      t.string    :action,          :null => false, :default => "Pre-Round"
      t.boolean   :finished,        :null => false, :default => false

      t.timestamps
    end
    add_index :rounds, :tournament_id
    add_index :rounds, [:tournament_id, :number], :name => "index_rounds_on_round_attributes", :unique => true
  end
end
