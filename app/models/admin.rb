class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable,
         :lockable, :timeoutable

  attr_accessor :authorization_code

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,
                  :active, :authorization_code

  validates :email, :email => true, :length => { :in => 6..140 }
  validates :name, :presence => true, :length => { :in => 2..140 }
end
