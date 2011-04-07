class SeasonalPurchaseExpectation < ActiveRecord::Base
  belongs_to :seasonal_purchase
  has_one :product, :through => :seasonal_purchase
  validates_uniqueness_of :year, :scope => :seasonal_purchase_id

  def history
    seasonal_purchase.seasonal_purchase_histories.where(:year => year - 1).first
  end
end
