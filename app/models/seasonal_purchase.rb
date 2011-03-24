class SeasonalPurchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :reseller
  has_many :seasonal_purchase_expectations
  has_many :seasonal_purchase_histories
end
