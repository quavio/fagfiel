class OrdersController < ApplicationController
  inherit_resources
  defaults :resource_class => Order, :collection_name => 'orders', :instance_name => 'order'

  def index
    @orders = Order.find(:all, :order => "created_at DESC")
  end

  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        Mailer.new_order(@order).deliver
        format.html { redirect_to(@order.freebie, :notice => I18n.t("notices.orders.create")) }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { redirect_to(@order.freebie, :alert => I18n.t("alerts.orders.insuficient_found", :reseller => @order.reseller.name)) }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @order = Order.find(params[:id])
    respond_to do |format|
      @order.update_attributes!(params[:order])
      format.html { redirect_to(orders_path, :notice => I18n.t("notices.orders.delivered")) }
    end
  end
end
