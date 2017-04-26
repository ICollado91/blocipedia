class User < ApplicationRecord
  attr_accessor :role
  has_many :wikis, dependent: :destroy
  after_initialize :init
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  
  USER_ROLES = {
    :admin => 0,
    :premium => 1,
    :standard => 2
  }
  
  def init
    self.role ||= USER_ROLES[:standard]
  end
  
  def set_as_admin
    self.role = USER_ROLES[:admin]
  end
  
  def set_as_premium
    self.role = USER_ROLES[:premium]
  end
  
  def can_edit?(wiki)
    true if owns?(wiki) || admin?
  end
  
  def can_destroy?(wiki)
    true if owns?(wiki) || admin?
  end
  
  def owns?(wiki)
    true if self.id == wiki.user_id
  end
  
  def admin?
    true if self.role_name == :admin
  end
  
  def role_name
    User.user_roles.key(self.role)
  end
  
  def self.user_roles
    USER_ROLES
  end
  
end
