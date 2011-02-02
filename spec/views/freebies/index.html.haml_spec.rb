require 'spec_helper'

describe "freebies/index" do
  before :each do
    assign(:freebies, [
        stub_model(Freebie),
        stub_model(Freebie)
      ])
  end

  context "when admin is logged in" do
    before :each do
      controller.stub(:current_user).and_return(create_user(:role => "a"))
    end
    it "should present new freebie link" do
      render
      assert_select "a", :href => new_freebie_path
    end
  end
end
