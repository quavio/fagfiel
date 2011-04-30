# coding:utf-8
require 'spec_helper'

describe "shared/_r_menu" do
  before :each do
    controller.stub(:current_user).and_return(stub_model(User, :is_reseller? => true, :reseller => stub_model(Reseller, :id => 1)))
    render
  end

  it {assert_select "a", :text => "Brindes"}
  it {assert_select "a", :text => "Previsão de compra"}
  it {assert_select "a", :text => "Contato"}
  it {assert_select "a", :text => "Montagem de rolamentos"}
end
