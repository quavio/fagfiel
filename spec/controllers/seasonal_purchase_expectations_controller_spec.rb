require 'spec_helper'

describe SeasonalPurchaseExpectationsController do
  describe "POST create" do
    context "admin is signed in" do
      login_as_admin
      it "redirects to root" do
        post :create, :reseller_id => 1, :year => 2000, :month => 1
        response.should redirect_to(root_url)
      end
    end

    context "manager is signed in" do 
      login_as_manager
      it "redirects to root" do
        post :create, :reseller_id => 1, :year => 2000, :month => 1
        response.should redirect_to(root_url)
      end
    end

    context "reseller is signed in" do
      let(:user){create_user :role => "r"}
      let(:reseller){create_reseller :user => user}
      let(:product){create_product}
      before :each do; sign_in user; end

      it "creates a new purchase expectation" do
        expect{
          post :create, :reseller_id => reseller.id, :year => Date.today.year, :month => Date.today.month, :product_id => product.id, :seasonal_purchase_expectation => {:quantity => 10}
        }.to change{SeasonalPurchaseExpectation.count}.by(1)
      end

      it "can not create a purchase expectation for another reseller" do
        reseller.reload
        another_reseller = create_reseller
        expect{
          post :create, :reseller_id => another_reseller.id, :year => Date.today.year, :month => Date.today.month, :product_id => product.id, :seasonal_purchase_expectation => {:quantity => 10}
        }.to_not change{SeasonalPurchaseExpectation.count}
      end
    end
  end
end
