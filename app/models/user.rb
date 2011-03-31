class User < ActiveRecord::Base
  has_one :reseller
  has_many :resellers, :foreign_key => "manager_id"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone, :name, :role

  def is_admin?
    role == "a"
  end
  
  def is_manager?
    role == "m"
  end
  
  def is_reseller?
    role == "r"
  end
end
