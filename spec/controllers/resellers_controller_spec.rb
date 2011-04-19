require 'spec_helper'

describe ResellersController do
  let(:admin){create_user :role => "a"}
  let(:manager){create_user :role => "m"}
  let(:reseller){create_user :role => "r"}
  let(:reseller1){stub_model(Reseller, :credits => 2000, :goal => 2000)}
  let(:reseller2){stub_model(Reseller, :credits => 0, :goal => 2000)}

  before(:each) do
    Reseller.stub(:all).and_return([reseller1, reseller2])
    Reseller.stub(:find).with(1).and_return(reseller1)
    reseller1.stub(:save).and_return(true)
    Reseller.stub(:find).with(1).and_return(reseller1)
    User.any_instance.expects(:resellers).returns([reseller1])
  end

  context "when admin is signed in" do
    before(:each){sign_in admin}

    describe "GET 'index'" do
      before(:each){get 'index'}
      it{should assign_to(:resellers).with([reseller2, reseller1])}
    end

    describe "GET 'edit'" do
      before(:each){get 'edit', :id => 1}
      it{should assign_to(:reseller).with(reseller1)}
    end

    describe "PUT 'update'" do
      before(:each){put 'update', :id => 1}
      it{should redirect_to(resellers_path)}
    end
  end

  context "when manager is signed in" do
    before(:each){sign_in manager}

    describe "GET 'index'" do
      before(:each){get 'index'}
      it{should assign_to(:resellers).with([reseller1])}
    end

    describe "GET 'edit'" do
      before(:each){get 'edit', :id => 1}
      it{should redirect_to(root_path)}
      it{should set_the_flash.to(I18n.t("alerts.require_admin"))}
    end

    describe "PUT 'update'" do
      before(:each){put 'update', :id => 1}
      it{should redirect_to(root_path)}
      it{should set_the_flash.to(I18n.t("alerts.require_admin"))}
    end
  end

  context "when reseller is signed in" do
    before(:each){sign_in reseller}

    describe "GET 'index'" do
      before(:each){get 'index'}
      it{should redirect_to(root_path)}
      it{should set_the_flash.to(I18n.t("alerts.require_admin_or_manager"))}
    end

    describe "GET 'edit'" do
      before(:each){get 'edit', :id => 1}
      it{should redirect_to(root_path)}
      it{should set_the_flash.to(I18n.t("alerts.require_admin"))}
    end

    describe "PUT 'update'" do
      before(:each){put 'update', :id => 1}
      it{should redirect_to(root_path)}
      it{should set_the_flash.to(I18n.t("alerts.require_admin"))}
    end
  end
end
