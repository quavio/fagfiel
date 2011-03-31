class SeasonalPurchaseExpectationsController < ApplicationController
  before_filter :require_reseller, :only => [:create]
  before_filter :require_same_reseller
  before_filter {@reseller = Reseller.find(params[:reseller_id])}

  def index
    @purchase_expectations = @reseller.purchase_expectations_for(params[:month], params[:year])
    @seasonal_purchase_expectation = SeasonalPurchaseExpectation.new
    @date = Date.new(params[:year].to_i, params[:month].to_i)
  end

  def create
    product = Product.find_by_reference(params[:product_reference])
    seasonal_purchase = SeasonalPurchase.find_by_reseller_id_and_product_id_and_month(@reseller.id, product.id, params[:month].to_i)
    if seasonal_purchase
    else
      seasonal_purchase = SeasonalPurchase.create :product_id => product.id, :reseller => @reseller, :month => params[:month]
      SeasonalPurchaseExpectation.create :seasonal_purchase => seasonal_purchase, :year => params[:year], :quantity => params[:seasonal_purchase_expectation][:quantity]
    end
    redirect_to reseller_seasonal_purchase_expectations_path(@reseller, params[:year], params[:month])
  end
end
