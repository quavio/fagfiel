require 'spec_helper'

describe UsersController do
  login

  def mock_user(stubs={})
    (@mock_user ||= mock_model(User).as_null_object).tap do |user|
      user.stub(stubs) unless stubs.empty?
    end
  end

  describe "PUT update" do
    context "when it is a reseller" do
      it "should send an email" do
        User.stub(:find) { mock_user(:update_attributes => true) }
        expect {
          put :update, :id => "1"
        }.to change {ActionMailer::Base.deliveries.size}.by(1)
      end
    end
  end

end
