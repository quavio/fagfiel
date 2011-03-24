class Product < ActiveRecord::Base
  has_many :seasonal_purchases
end
