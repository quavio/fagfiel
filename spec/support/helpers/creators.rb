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
end
RSpec.configuration.include Creators
