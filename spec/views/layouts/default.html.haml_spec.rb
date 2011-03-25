require 'spec_helper'

describe "layouts/default" do
  subject { rendered }

  context "when reseller is logged in" do
    before :each do
      u = create_user(:role => "r")
      create_reseller :user => u
      controller.stub(:current_user).and_return(u)
      render
    end
    it { should_not match /<a.*>#{t('links.menu.courses')}<\/a>/ } 
  end

  context "when manager is logged in" do
    before :each do
      controller.stub(:current_user).and_return(create_user(:role => "m"))
      render
    end
    it { should_not match /<a.*>#{t('links.menu.courses')}<\/a>/ } 
  end

  context "when admin is logged in" do
    before :each do
      controller.stub(:current_user).and_return(create_user(:role => "a"))
      render
    end
    it { should match /<a.*>#{t('links.menu.courses')}<\/a>/ } 
  end
end

