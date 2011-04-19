class SeasonalPurchaseHistoriesController < ApplicationController
  before_filter {@reseller = Reseller.find(params[:reseller_id])}
  skip_before_filter :authenticate_user!
  layout nil
  
  def index
    product = Product.find_by_reference(params[:product_reference])
    seasonal_purchase = SeasonalPurchase.find_by_product_id_and_reseller_id_and_month(product.id, @reseller.id, params[:month])
    if seasonal_purchase
      @seasonal_purchase_history = seasonal_purchase.seasonal_purchase_histories.find_by_year(params[:year])
    end
  end

end
