require 'spec_helper'

describe CoursesController do
  before(:each) do
    sign_out :user
    user = create_user(:role => "a")
    sign_in user
    @course = create_course
  end
  describe "GET index" do
    subject { assigns(:courses) }
    before(:each) { get :index }
    it("should respond successfully") { response.should be_success }
    it("should list all courses") { should == [@course] }
  end

end
