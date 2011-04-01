require 'spec_helper'

describe CoursesController do
  before(:each) do
    sign_out :user
    user = create_user(:role => "r")
    create_reseller(:user => user)
    sign_in user
    @course = create_course :start_at => Time.now + 1.day
  end

  describe "GET new" do
    it "assigns a new course as @course" do
      get :new
      assigns(:course).id.should be_nil
    end
  end

  describe "GET edit" do
    it "assigns the requested course as @course" do
      get :edit, :id => @course.id
      assigns(:course).id.should eq(@course.id)
    end
  end

  describe "GET index" do
    before(:each){ get :index }

    it "assigns all active courses as @courses" do
      Set.new(assigns(:courses)).should == Set.new(Course.active.all)
    end
    context "when we have courses in the future" do
      before(:each){ @future = create_course :start_at => Time.now + 1.day }
      it "assigns all active courses as @courses" do
        Set.new(assigns(:courses)).should == Set.new(Course.active.all)
      end
    end
  end
end
