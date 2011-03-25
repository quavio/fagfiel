require 'spec_helper'

describe Course do
  context "when I create a course with default parameters" do
    subject { create_course }
    its(:class) { should == Course }
  end

  context "when we have courses which start_at is in the past" do
    subject { Course }
    before(:each) do
      @c = create_course :start_at => Time.now - 1.day
    end
    its(:active) { should == [@c] }
  end
end
