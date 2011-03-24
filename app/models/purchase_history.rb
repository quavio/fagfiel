class PurchaseHistory < ActiveRecord::Base
  belongs_to :reseller
  belongs_to :product
end
