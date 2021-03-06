# encoding: utf-8
class Reseller < ActiveRecord::Base
  belongs_to :user
  belongs_to :manager, :class_name => 'User', :foreign_key => :manager_id
  has_many :orders
  has_many :seasonal_purchases
  has_many :seasonal_purchase_expectations, :through => :seasonal_purchases
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

  def goal_percentage
    (credits / goal * 100).round
  end

  def purchase_expectations_for month, year
    seasonal_purchase_expectations.where('seasonal_purchases.month = ? AND year = ?', month, year)
  end
end
