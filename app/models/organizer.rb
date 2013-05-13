class Organizer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :active, :username, :name, :timezone

  validates_presence_of :email, :password, :password_confirmation, :name, :mykad_passport, :handphone_no
  validates_uniqueness_of :email, :mykad_passport, :handphone_no

  has_many :organizer_services
  has_many :tournaments
end
