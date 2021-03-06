class FreebiesController < ApplicationController
  inherit_resources
  defaults :resource_class => Freebie, :collection_name => 'freebies', :instance_name => 'freebie'
  before_filter :require_admin, :except => [:show, :index]

  def show
    @freebie = Freebie.find params[:id]
    if current_user.reseller
      @order = Order.new(:freebie => @freebie, :reseller => current_user.reseller)
    end
  end
end
