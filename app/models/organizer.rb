class Organizer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  attr_accessor :authentication_code

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :active, :authentication_code, :name, :username, :time_zone

  validates :email, :email => true, :length => { :in => 6..140 }
  validates :name, :presence => true, :length => { :in => 2..140 }

  has_many :organizer_services
  has_many :tournaments

  private

  def self.activate_or_create(params_organizer)
    if params_organizer[:email] and not params_organizer[:email].blank?
      organizer = Organizer.find_by_email params_organizer[:email]
      organizer.active = true if organizer
    end
    organizer = Organizer.new(params_organizer) unless organizer
    organizer
  end
end
