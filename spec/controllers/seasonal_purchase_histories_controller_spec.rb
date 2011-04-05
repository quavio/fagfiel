require 'spec_helper'

describe SeasonalPurchaseHistoriesController do
  describe "GET index" do
    it "shows purchase history" do
      reseller = create_reseller
      product = create_product
      seasonal_purchase = create_seasonal_purchase :product => product, :reseller => reseller, :month => Date.today.month
      seasonal_purchase_history = create_purchase_history :seasonal_purchase => seasonal_purchase, :year => Date.today.year - 1, :consulted => 10, :bought => 10
      get "index", :reseller_id => reseller.id, :year => Date.today.year - 1, :month => Date.today.month, :product_reference => product.reference
      assigns[:seasonal_purchase_history].should be_== seasonal_purchase_history
    end
  end
end
