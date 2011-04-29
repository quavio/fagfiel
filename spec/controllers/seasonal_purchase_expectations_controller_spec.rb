require 'spec_helper'

describe SeasonalPurchaseExpectationsController do

  context "admin is signed in" do
    login_as_admin

    describe "POST create" do
      it "redirects to root" do
        post :create, :reseller_id => 1, :year => 2000, :month => 1
        response.should redirect_to(root_url)
      end
    end

  end

  context "manager is signed in" do 
    login_as_manager

    describe "POST create" do
      it "redirects to root" do
        post :create, :reseller_id => 1, :year => 2000, :month => 1
        response.should redirect_to(root_url)
      end
    end

  end

  context "reseller is signed in" do
    let(:user){create_user :role => "r"}
    let(:manager){create_user :role => "m"}
    let(:reseller){create_reseller :user => user, :manager => manager}
    let(:product){create_product}
    let(:seasonal_purchase){create_seasonal_purchase :reseller => reseller, :product => product}
    let(:seasonal_purchase_expectation){create_purchase_expectation :seasonal_purchase => seasonal_purchase}
    before(:each){sign_in user}

    describe "POST create" do

      it "creates a new purchase expectation" do
        expect{
          post :create, :reseller_id => reseller.id, :year => Date.today.year, :month => Date.today.month, :product_reference => product.reference, :seasonal_purchase_expectation => {:quantity => 10}
        }.to change{SeasonalPurchaseExpectation.count}.by(1)
      end

      it "can not create a purchase expectation for another reseller" do
        reseller.reload
        another_reseller = create_reseller
        expect{
          post :create, :reseller_id => another_reseller.id, :year => Date.today.year, :month => Date.today.month, :product_reference => product.reference, :seasonal_purchase_expectation => {:quantity => 10}
        }.to_not change{SeasonalPurchaseExpectation.count}
      end

      it "should send an email to reseller manager" do
        post :create, :reseller_id => reseller.id, :year => Date.today.year, :month => Date.today.month, :product_reference => product.reference, :seasonal_purchase_expectation => {:quantity => 10}
        ActionMailer::Base.deliveries.last.to.should be_== [manager.email]
      end

    end

    describe "PUT update" do
      before(:each){put :update, :reseller_id => reseller.id, :year => Date.today.year, :month => Date.today.month, :id => seasonal_purchase_expectation.id, :seasonal_purchase_expectation => {:quantity => 10}}

      it "should send an email to reseller manager" do
        ActionMailer::Base.deliveries.last.to.should be_== [manager.email]
      end
    end

    describe "DELETE destroy" do
      let(:seasonal_purchase_expectation_to_be_destroyed){create_purchase_expectation :seasonal_purchase => seasonal_purchase}
      before(:each){delete :destroy, :reseller_id => reseller.id, :year => Date.today.year, :month => Date.today.month, :id => seasonal_purchase_expectation_to_be_destroyed.id}

      it "should send an email to reseller manager" do
        ActionMailer::Base.deliveries.last.to.should be_== [manager.email]
      end

    end

  end
end
