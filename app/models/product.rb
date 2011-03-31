class Product < ActiveRecord::Base
  has_many :seasonal_purchases
  
  index do
    reference
    brand
    group
  end

end
