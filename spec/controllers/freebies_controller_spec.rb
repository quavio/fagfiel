#coding:utf-8
require 'spec_helper'

describe FreebiesController do
  context "when admin is logged in" do
    before :each do
      user = create_user :role => "a"
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

  context "when reseller is logged in" do
    before(:each) do
      user = create_user(:role => "r")
      create_reseller(:user => user)
      sign_in user
    end
    let(:freebie){create_freebie}

    describe "GET show" do
      before :each do; get :show, :id => freebie.id; end
      it{should assign_to(:order).with_kind_of(Order)}
    end

  end

  ["r", "m"].each do |role|
    context "when reseller or manager is logged in" do
      let(:user){create_user(:role => role)}
      let(:reseller){create_reseller :user => user}
      let(:freebie){create_freebie}
      before :each do; sign_in user; end

      describe "GET index" do
        before :each do; get :index; end
        it{should assign_to(:freebies).with([freebie])}
      end

      describe "GET show" do
        before :each do; get :show, :id => freebie.id; end
        it{should assign_to(:freebie).with(freebie)}
      end

      describe "GET new" do
        before :each do; get :new; end
        it{should respond_with(:redirect)}
        it{should set_the_flash.to("Apenas administradores podem acessar esta página.")}
      end

      describe "GET edit" do
        before :each do; get :edit, :id => freebie.id; end
        it{should respond_with(:redirect)}
        it{should set_the_flash.to("Apenas administradores podem acessar esta página.")}
      end

      describe "POST create" do
        before :each do; post :create, :freebie => {'title' => 'new freebie'}; end
        it{should respond_with(:redirect)}
        it{should set_the_flash.to("Apenas administradores podem acessar esta página.")}
      end

      describe "PUT update" do
        before :each do; put :update, :id => freebie.id, :freebie => {'title' => 'updated'}; end
        it{should respond_with(:redirect)}
        it{should set_the_flash.to("Apenas administradores podem acessar esta página.")}
      end

      describe "DELETE destroy" do
        before :each do; delete :destroy, :id => freebie.id; end
        it{should respond_with(:redirect)}
        it{should set_the_flash.to("Apenas administradores podem acessar esta página.")}
      end

    end
  end
end
