require 'spec_helper'

describe ResellersController do

  context "when admin is signed in" do
    before :each do
      sign_out :user
      sign_in create_user(:role => "a")
    end

    describe "GET 'index'" do
      it "should assign all resellers to @resellers" do
        get 'index'
        assigns[:resellers].should be_== Reseller.all
      end
    end

    describe "GET 'edit'" do
      it "should assign @reseller" do
        reseller = create_reseller
        get 'edit', :id => reseller
        assigns[:reseller].should be_== reseller
      end
    end

    describe "PUT 'update'" do
      it "should redirect to resellers" do
        reseller = create_reseller
        put 'update', :id => reseller
        response.should redirect_to(resellers_path)
      end
    end
  end

  context "when manager is signed in" do
    before :each do
      @manager = create_user(:role => "m")
      sign_out :user
      sign_in @manager
    end

    describe "GET 'index'" do
      it "should respond succefully" do
        get 'index'
        assigns[:resellers].should be_empty
        response.should be_success
      end
    end

    context "and has resellers" do
      before :each do
        @reseller1 = create_reseller
        @reseller2 = create_reseller(:manager => @manager)
      end

      describe "GET 'index'" do
        it "should assign only manager's resellers to @resellers" do
          get 'index'
          assigns[:resellers].should be_== [@reseller2]
        end
      end

      describe "GET 'edit'" do
        it "should be redirected" do
          reseller = create_reseller
          get 'edit', :id => reseller
          flash[:alert].should be_== I18n.t("alerts.require_admin")
          response.should redirect_to(root_path)
        end
      end

      describe "PUT 'update'" do
        it "should be redirected" do
          reseller = create_reseller
          put 'update', :id => reseller
          flash[:alert].should be_== I18n.t("alerts.require_admin")
          response.should redirect_to(root_path)
        end
      end
    end
  end

  context "when reseller is signed in" do
    before :each do
      sign_out :user
      sign_in create_user(:role => "r")
    end

    describe "GET 'index'" do
      it "should be redirected" do
        get 'index'
        flash[:alert].should be_== I18n.t("alerts.require_admin_or_manager")
        response.should redirect_to(root_path)
      end
    end

    describe "GET 'edit'" do
      it "should be redirected" do
        reseller = create_reseller
        get 'edit', :id => reseller
        flash[:alert].should be_== I18n.t("alerts.require_admin")
        response.should redirect_to(root_path)
      end
    end

    describe "PUT 'update'" do
      it "should be redirected" do
        reseller = create_reseller
        put 'update', :id => reseller
        flash[:alert].should be_== I18n.t("alerts.require_admin")
        response.should redirect_to(root_path)
      end
    end
  end
end
