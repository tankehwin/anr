class DeviseCreateOrganizers < ActiveRecord::Migration
  def change
    create_table(:organizers) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      # Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      # Token authenticatable
      t.string :authentication_token


      t.string  :username
      t.string  :name,              :null => false, :default => ""
      t.string  :time_zone,         :null => false, :default => "Kuala Lumpur"
      t.integer :boost_tank_current_amount,         :null => false, :default => 10
      t.integer :boost_tank_full_limit,             :null => false, :default => 10
      t.integer :boost_limit_per_tournament,        :null => false, :default => 2
      t.boolean :active,            :null => false, :default => true

      t.timestamps
    end

    add_index :organizers, :email,                :unique => true
    add_index :organizers, :reset_password_token, :unique => true
    add_index :organizers, :confirmation_token,   :unique => true
    add_index :organizers, :unlock_token,         :unique => true
    add_index :organizers, :authentication_token, :unique => true
    add_index :organizers, :username,             :unique => true
  end
end
