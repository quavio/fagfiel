# coding:utf-8
class SeasonalPurchaseExpectationsController < ApplicationController
  before_filter :require_reseller, :only => [:create]
  before_filter :require_same_reseller
  before_filter {@reseller = Reseller.find(params[:reseller_id])}
  before_filter {@date = Date.new(params[:year].to_i, params[:month].to_i)}

  def index
    @purchase_expectations = @reseller.purchase_expectations_for(params[:month], params[:year])
    @seasonal_purchase_expectation = SeasonalPurchaseExpectation.new
  end

  def create
    product = Product.find_by_reference(params[:product_reference])
    if product
      seasonal_purchase = SeasonalPurchase.find_or_create_by_product_id_and_reseller_id_and_month(product.id, @reseller.id, params[:month])
      unless SeasonalPurchaseExpectation.create(params[:seasonal_purchase_expectation].merge({:seasonal_purchase => seasonal_purchase, :year => params[:year]})).valid?
        flash[:alert] = t("alerts.seasonal_purchase_expectations.expectation_already_exist", :product => product.reference)
      end
    else
      flash[:alert] = t("alerts.seasonal_purchase_expectations.invalid_product")
    end
    redirect_to reseller_seasonal_purchase_expectations_path(@reseller, params[:year], params[:month])
  end

  def edit
    @seasonal_purchase_expectation = SeasonalPurchaseExpectation.find(params[:id])
  end

  def update
    seasonal_purchase_expectation = SeasonalPurchaseExpectation.find(params[:id])
    seasonal_purchase_expectation.update_attributes(params[:seasonal_purchase_expectation])
    redirect_to reseller_seasonal_purchase_expectations_path(@reseller, seasonal_purchase_expectation.year, seasonal_purchase_expectation.seasonal_purchase.month)
  end

  def destroy
    seasonal_purchase_expectation = SeasonalPurchaseExpectation.find(params[:id])
    seasonal_purchase_expectation.destroy
    redirect_to reseller_seasonal_purchase_expectations_path(@reseller, params[:year], params[:month])
  end
end
