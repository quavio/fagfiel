require 'spec_helper'

describe "courses/index" do
  subject { rendered }
  before :each do
    assign(:courses, [stub_model(Course)])
  end

  context "when admin is logged in" do
    before :each do
      controller.stub(:current_user).and_return(stub_model(User, :role => 'a'))
      render
    end
    it "should present courses list" do
      assert_select(".course", 1)
    end
  end
end


