require 'spec_helper'

describe CoursesController do
  before(:each) do
    sign_out :user
    user = create_user(:role => "r")
    create_reseller(:user => user)
    sign_in user
    @course = create_course
  end

  describe "GET index" do
    it "assigns all active courses as @courses" do
      get :index
      Set.new(assigns(:courses)).should == Set.new(Course.active.all)
    end
  end
end
