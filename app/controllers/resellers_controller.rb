class ResellersController < ApplicationController
  def index
  end

  def edit
    @reseller = Reseller.find params[:id]
  end

  def update
  end

end
