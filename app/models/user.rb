class User < ApplicationRecord
  
  USER_ROLES = {
    :admin => 0,
    :premium => 1,
    :standard => 2
  }
  
  attr_accessor(:login)
  
  has_many :wikis, dependent: :destroy
  after_initialize :init
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :authentication_keys => [:login]
  
  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  
  
  
  def init
    self.role ||= USER_ROLES[:standard]
  end
  
  def role_name
    User.user_roles.key(self.role)
  end
  
  def self.user_roles
    USER_ROLES
  end
  
  def admin?
    self.role_name == :admin
  end
  
  def premium?
    true if self.role_name == :premium
  end
  
  def standard?
    true if self.role_name == :standard
  end
  
  def set_to_premium
    self.role = USER_ROLES[:premium]
    self.save!
  end
  
  def set_to_standard
    self.role = USER_ROLES[:standard]
    self.save!
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
  
end
