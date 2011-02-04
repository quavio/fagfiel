#coding:utf-8
class Order < ActiveRecord::Base
  belongs_to :reseller
  belongs_to :freebie
  validate {|order| errors.add(:reseller, I18n.t("activerecord.errors.messages.insuficient_found")) if order.freebie.price > order.reseller.balance}
  before_create {|order| order.price = order.freebie.price}
end
