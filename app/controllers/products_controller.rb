class ProductsController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @products = Product.search(params[:search] || "")
    respond_to do |format|
      format.json {render :json => @products}
    end    
  end

end
