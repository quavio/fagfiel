require 'spec_helper'

describe ResellersController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => create_reseller
      response.should be_success
    end

    it "should assign @reseller" do
      reseller = create_reseller
      get 'edit', :id => reseller
      assigns[:reseller].should be_== reseller
    end
  end
end
