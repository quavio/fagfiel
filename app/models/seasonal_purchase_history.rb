class SeasonalPurchaseHistory < ActiveRecord::Base
  belongs_to :seasonal_purchase
  has_one :product, :through => :seasonal_purchase
end
