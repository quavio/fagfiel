# encoding: utf-8
require 'spec_helper'

describe "resellers/index.html.haml" do
  context "manager is loged in" do
    before(:each) do
      @manager = create_user(:role => "m")
      @reseller1 = create_reseller
      @reseller2 = create_reseller(:manager => @manager)
    end

    it "renders restaurants list with specialties and cuisines" do
      assign(:resellers, [@reseller1])
      render
      assert_select('.reseller', 1) do |r|
         assert_select('span.ui-label b', 1)
      end
    end
  end
end

