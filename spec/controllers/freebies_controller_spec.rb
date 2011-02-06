require 'spec_helper'

describe FreebiesController do
  before(:each) do
    sign_out :user
    user = create_user(:role => "r")
    create_reseller(:user => user)
    sign_in user
    @freebie = create_freebie
  end

  describe "GET index" do
    it "assigns all freebies as @freebies" do
      get :index
      assigns(:freebies).map{ |f| f.id }.should eq([@freebie.id])
    end
  end

  describe "GET show" do
    it "assigns the requested freebie as @freebie" do
      get :show, :id => @freebie.id
      assigns(:freebie).id.should eq(@freebie.id)
      assigns(:order).freebie.should be_== @freebie
    end
  end

  describe "GET new" do
    it "assigns a new freebie as @freebie" do
      get :new
      assigns(:freebie).id.should be_nil
    end
  end

  describe "GET edit" do
    it "assigns the requested freebie as @freebie" do
      get :edit, :id => @freebie.id
      assigns(:freebie).id.should eq(@freebie.id)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created freebie as @freebie" do
        post :create, :freebie => {'title' => 'new freebie'}
        assigns(:freebie).id.should be(Freebie.where(["id <> ?", @freebie.id]).first.id)
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested freebie" do
        put :update, :id => @freebie.id, :freebie => {'title' => 'updated'}
        @freebie.reload.title.should == 'updated'
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested freebie" do
      id = @freebie.id
      delete :destroy, :id => id
      response.should redirect_to(freebies_url)
      Freebie.find_by_id(id).should be_nil
    end
  end

end
