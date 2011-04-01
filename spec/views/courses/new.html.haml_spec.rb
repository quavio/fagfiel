require 'spec_helper'

describe "courses/new" do
  subject { rendered }
  before :each do
    assign(:course, stub_model(Course))
  end

  context "when admin is logged in" do
    before :each do
      controller.stub(:current_user).and_return(stub_model(Course))
      render
    end
    it "should present new course form" do
      assert_select "form"
    end
  end
end

