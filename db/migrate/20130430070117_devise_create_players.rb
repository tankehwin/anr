class DeviseCreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
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


      t.string  :username,          :null => false, :default => ""
      t.string  :login
      t.string  :name,              :null => false, :default => ""
      t.integer :prestiges,         :null => false, :default => 0
      t.integer :game_points,       :null => false, :default => 0
      t.integer :matches,           :null => false, :default => 0
      t.integer :matches_with_bye,  :null => false, :default => 0
      t.integer :bye_prestiges,     :null => false, :default => 0
      t.integer :bye_game_points,   :null => false, :default => 0
      t.integer :tournaments,       :null => false, :default => 0
      t.float   :rating,            :null => false, :default => 1400.0
      t.integer :country_id,        :null => false, :default => 122
      t.boolean :active,            :null => false, :default => true

      t.timestamps
    end
    
    add_index :players, :email,                 :unique => true
    add_index :players, :reset_password_token,  :unique => true
    add_index :players, :confirmation_token,    :unique => true
    add_index :players, :unlock_token,          :unique => true
    add_index :players, :authentication_token,  :unique => true
    add_index :players, :username,              :unique => true
    add_index :players, :login,                 :unique => true
    add_index :players, :prestiges
    add_index :players, :game_points
    add_index :players, :matches
    add_index :players, :tournaments
    add_index :players, :rating
    add_index :players, :active
  end
end
