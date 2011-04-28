class SeasonalPurchaseExpectation < ActiveRecord::Base
  belongs_to :seasonal_purchase
  has_one :product, :through => :seasonal_purchase
  has_one :reseller, :through => :seasonal_purchase
  validates_uniqueness_of :year, :scope => :seasonal_purchase_id

  def history
    seasonal_purchase.seasonal_purchase_histories.where(:year => year - 1).first
  end

  def last_three_months_history
    date = Date.new year, seasonal_purchase.month
    sphs = []
    1.upto(3) do |i|
      sp = SeasonalPurchase.find_by_product_id_and_reseller_id_and_month(product.id, reseller.id, (date - i.month).month)
      sph = sp ? SeasonalPurchaseHistory.find_by_seasonal_purchase_id_and_year(sp.id, (date - i.month).year) : nil
      sphs << sph
    end
    sphs
  end
end
