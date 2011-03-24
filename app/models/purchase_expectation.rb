class PurchaseExpectation < ActiveRecord::Base
  belongs_to :product
  belongs_to :reseller

  def history
    PurchaseHistory.find_by_product_id_and_reseller_id_and_year_and_month(product.id, reseller.id, year - 1, month)
  end
end
