class FreebiesController < ApplicationController
  inherit_resources
  defaults :resource_class => Freebie, :collection_name => 'freebies', :instance_name => 'freebie'

  def show
    @freebie = Freebie.find params[:id]
    @order = Order.new(:freebie => @freebie, :reseller => current_user.reseller)
  end
end
