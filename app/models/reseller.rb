# encoding: utf-8

class Reseller < ActiveRecord::Base
  belongs_to :user
  belongs_to :manager, :class_name => 'User', :foreign_key => :manager_id
  has_many :orders
  validate :verify_user_is_not_manager

  def verify_user_is_not_manager
    errors.add(:manager, 'O revendedor não pode ser seu próprio gerente') if user == manager
  end

  def debits
    orders.map{|o| o.price}.sum
  end

  def balance
    self.credits - self.debits
  end

end
