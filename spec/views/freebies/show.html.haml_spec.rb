require 'spec_helper'

describe "freebies/show" do
  before :each do
    @freebie = assign(:freebie, stub_model(Freebie))
    assign(:order, stub_model(Order))
  end

  context "when admin is logged in" do
    before :each do
      user = create_user(:role => "a")
      reseller = create_reseller(:user => user)
      controller.stub(:current_user).and_return(user)
    end

    it "should present new freebie link" do
      render
      assert_select "a", :href => edit_freebie_path(@freebie)
    end

  end
end
