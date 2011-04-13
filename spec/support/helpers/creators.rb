module Creators
  @@serial = 0

  def create_user options = {}
    defaults = {
      :email => "person#{@@serial += 1}@quavio.com.br",
      :password => 'test pass salt'
    }.merge(options)
    User.create(defaults)
  end
  
  def create_reseller options = {}
    defaults = {
      :name => "reseller #{@@serial += 1}",
      :manager => create_user,
      :user_id => create_user.id
    }.merge(options)
    Reseller.create(defaults)
  end
  
  def create_course options = {}
    defaults = {
      :start_at => Date.today + 1,
      :title => "course #{@@serial += 1}"
    }.merge(options)
    Course.create(defaults)
  end

  def create_freebie options = {}
    defaults = {
      :title => "freebie #{@@serial += 1}"
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
      :code => @@serial += 1,
      :reference => "REF #{@@serial += 1}",
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
      :quantity => @@serial += 1,
      :year => Date.today.year
    }.merge(options)
    SeasonalPurchaseExpectation.create(defaults)
  end

  def create_purchase_history options = {}
    defaults = {
      :seasonal_purchase => create_seasonal_purchase,
      :consulted => @@serial += 1,
      :bought => @@serial += 1,
      :year => Date.today.year
    }.merge(options)
    SeasonalPurchaseHistory.create(defaults)
  end
end
RSpec.configuration.include Creators
