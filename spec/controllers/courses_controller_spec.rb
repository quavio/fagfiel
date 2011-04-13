require 'spec_helper'

describe CoursesController do
  let(:course){create_course}

  context "admin is signed in" do
    let(:user){create_user :role => "a"}
    before(:each){sign_in user}

    describe "GET new" do
      before(:each){get :new}
      it{should assign_to(:course).with_kind_of(Course)}
    end

    describe "GET edit" do
      before(:each){get :edit, :id => course.id}
      it{should assign_to(:course).with(course)}
    end

    describe "GET index" do
      let(:unactive_course){create_course :start_at => nil}
      before(:each){get :index}
      it{should assign_to(:courses).with([course, unactive_course])}
    end

    describe "POST create" do
      before(:each){post :create, :course => {'title' => 'new course'}}
      subject{assigns(:course)}
      it{should_not be_new_record}
    end

    describe "PUT update" do
      before(:each){put :update, :id => course.id, :course => {'title' => 'updated'}}
      subject{assigns(:course)}
      its(:title){should be_==('updated')}
    end

    describe "DELETE destroy" do
      before(:each){delete :destroy, :id => course.id}
      subject{Course.find_by_id(course.id)}
      it{should_not be}
    end

  end

  ["r", "m"].each do |type|
    context "#{type} is signed in" do
      let(:user){create_user :role => type}
      before(:each){sign_in user}

      describe "GET new" do
        before(:each){get :new}
        it{should redirect_to(root_path)}
      end

      describe "GET edit" do
        before(:each){get :edit, :id => course.id}
        it{should redirect_to(root_path)}
      end

      describe "GET index" do
        let(:unactive_course){create_course :start_at => nil}
        before(:each){get :index}
        it{should assign_to(:courses).with([course])}
      end

      describe "GET show" do
        before(:each){get :show, :id => course.id}
        it{should assign_to(:course).with(course)}
      end

      describe "POST create" do
        before(:each){post :create, :course => {'title' => 'new course'}}
        it{should redirect_to(root_path)}
      end

      describe "PUT update" do
        before(:each){put :update, :id => course.id, :course => {'title' => 'updated'}}
        it{should redirect_to(root_path)}
      end

      describe "DELETE destroy" do
        before(:each){delete :destroy, :id => course.id}
        it{should redirect_to(root_path)}
      end

    end
  end

end
