require 'spec_helper'

describe "layouts/default" do
  subject { rendered }

  context "when reseller is logged in" do
    before :each do
      controller.stub(:current_user).and_return(stub_model(User, :id => 1, :role => 'r', :reseller => stub_model(Reseller, :id => 2)))
      render
    end
  end

  context "when manager is logged in" do
    before :each do
      controller.stub(:current_user).and_return(stub_model(User, :id => 1, :role => 'm'))
      render
    end
  end

  context "when admin is logged in" do
    before :each do
      controller.stub(:current_user).and_return(stub_model(User, :id => 1, :role => 'a'))
      render
    end
  end
end

