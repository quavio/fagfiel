class PurchaseExpectationsController < ApplicationController
  def index
    @reseller = Reseller.find(params[:reseller_id])
    @date = Date.new(params[:year].to_i, params[:month].to_i)
    @purchase_expectations = @reseller.purchase_expectations.find_all_by_year_and_month(params[:year].to_i, params[:month].to_i)
  end
end
