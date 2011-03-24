module Creators
  
  def create_user options = {}
    defaults = {
      :email => "person#{(rand * 1000).round}@gmail.com",
      :password => 'test pass salt'
    }.merge(options)
    User.create(defaults)
  end
  
  def create_reseller options = {}
    defaults = {
      :name => "reseller #{(rand * 1000).round}",
      :manager => create_user,
      :user => create_user
    }.merge(options)
    Reseller.create(defaults)
  end
  
  def create_freebie options = {}
    defaults = {
      :title => "freebie #{(rand * 1000).round}"
    }.merge(options)
    Freebie.create(defaults)
  end

  def create_order options = {}
    defaults = {
      :freebie => create_freebie(:price => 1000),
      :reseller => create_reseller(:credits => 1000)
    }.merge(options)
    Order.create(defaults)
  end

  def create_product options = {}
    defaults = {
      :code => rand * 1000,
      :reference => "REF #{rand * 1000}",
      :brand => "FAG",
      :group => "Rolamentos"
    }.merge(options)
    Product.create(defaults)
  end

  def create_seasonal_purchase options = {}
    defaults = {
      :reseller => create_reseller,
      :product => create_product,
      :month => Date.today.month
    }.merge(options)
    SeasonalPurchase.create(defaults)
  end

  def create_purchase_expectation options = {}
    defaults = {
      :seasonal_purchase => create_seasonal_purchase,
      :quantity => rand * 1000,
      :year => Date.today.year
    }.merge(options)
    SeasonalPurchaseExpectation.create(defaults)
  end

  def create_purchase_history options = {}
    defaults = {
      :seasonal_purchase => create_seasonal_purchase,
      :consulted => rand * 1000,
      :bought => rand * 1000,
      :year => Date.today.year
    }.merge(options)
    SeasonalPurchaseHistory.create(defaults)
  end
end
RSpec.configuration.include Creators
