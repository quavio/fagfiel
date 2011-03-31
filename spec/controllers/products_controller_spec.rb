require 'spec_helper'

describe ProductsController do

  describe "GET 'index'" do
    let(:product){create_product}
    it "assigns found products to @products" do
      get 'index', :search => product.reference, :format => "json"
      assigns[:products].should be_== [product]
    end
  end

end
