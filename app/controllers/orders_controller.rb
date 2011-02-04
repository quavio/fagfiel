class OrdersController < ApplicationController
  inherit_resources
  defaults :resource_class => Order, :collection_name => 'orders', :instance_name => 'order'

  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        Mailer.new_order(@order).deliver
        format.html { redirect_to(@order.freebie, :notice => I18n.t("notices.orders.create")) }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        @freebie = @order.freebie
        format.html { render "freebies/show" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
end
