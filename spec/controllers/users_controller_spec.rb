require 'spec_helper'

describe UsersController do

  describe "GET edit" do
    login

    context "when it is another user edit page" do
      it "redirects to root" do
        get :edit, :id => 2
        response.should redirect_to(root_url)
      end
    end
  end

  describe "PUT update" do
    before :each do
      @user = create_user
      @user.stub(:reseller).and_return create_reseller
      sign_out :user
      sign_in @user
    end

    context "when it is a reseller" do
      it "should send an email" do
        User.stub(:find) {@user}
        expect {
          put :update, :id => @user.id, :user => {:password => ""}
        }.to change {ActionMailer::Base.deliveries.size}.by(1)
      end
    end

    it "should disconsider blank password" do
      User.stub(:find) {@user}
      put :update, :id => @user.id, :user => {:password => ""}
      assigns[:params].has_key?(:password).should be_false
    end

    context "when it is another user" do
      it "redirects to root" do
        put :update, :id => 2
        response.should redirect_to(root_url)
      end
    end
  end
end
