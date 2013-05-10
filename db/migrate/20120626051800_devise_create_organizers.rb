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


      t.string  :name,              :null => false, :default => ""
      t.string  :time_zone,         :null => false, :default => "Kuala Lumpur"
      t.integer :country_id,        :null => false, :default => 122
      t.string  :contact_person,    :null => false
      t.string  :mobile_no,         :null => false, :unique => true
      t.string  :postcode,          :null => false
      t.string  :address1,          :null => false
      t.string  :address2
      t.string  :city,              :null => false
      t.string  :state,             :null => false
      t.boolean :active,            :null => false, :default => true

      t.timestamps
    end

    add_index :organizers, :email,                :unique => true
    add_index :organizers, :reset_password_token, :unique => true
    add_index :organizers, :confirmation_token,   :unique => true
    add_index :organizers, :unlock_token,         :unique => true
    add_index :organizers, :authentication_token, :unique => true
  end
end