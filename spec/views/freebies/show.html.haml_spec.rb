require 'spec_helper'

describe "freebies/show" do
  before :each do
    @freebie = assign(:freebie, stub_model(Freebie))
  end

  context "when admin is logged in" do
    before :each do
      user = create_user(:role => "a")
      controller.stub(:current_user).and_return(user)
    end

    it "should present edit freebie link" do
      render
      assert_select "a", :href => edit_freebie_path(@freebie)
    end

  end
end
