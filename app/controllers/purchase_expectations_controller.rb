class PurchaseExpectationsController < ApplicationController
  def index
    @reseller = Reseller.find(params[:reseller_id])
    @date = Date.new(params[:year].to_i, params[:month].to_i)
    @purchase_expectations = @reseller.purchase_expectations.where("date >= ? AND date <= ?", @date, (@date + 1.month) - 1.day)
    @dates = ["Prever compras para:"]
    12.times do |i| 
      date = Date.today + i.month
      @dates << [l(date, :format => :month_and_year), reseller_purchase_expectations_path(@reseller, date.year, date.month)]
    end
  end
end
