require 'spec_helper'

describe "courses/show" do
  subject { rendered }
  before :each do
    assign(:course, stub_model(Course, :description => 'test course'))
  end

  context "when admin is logged in" do
    before :each do
      controller.stub(:current_user).and_return(stub_model(User, :role => 'a'))
      render
    end
    it "should present new course title" do
      rendered.should match /test course/
    end
  end
end

