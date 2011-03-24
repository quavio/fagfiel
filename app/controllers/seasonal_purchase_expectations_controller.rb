class SeasonalPurchaseExpectationsController < ApplicationController
  def index
    @reseller = Reseller.find(params[:reseller_id])
    @purchase_expectations = @reseller.purchase_expectations_for(params[:month], params[:year])
    @date = Date.new(params[:year].to_i, params[:month].to_i)
  end
end
