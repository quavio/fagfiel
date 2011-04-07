require 'spec_helper'

describe "shared/_a_menu" do
  before :each do
    controller.stub(:current_user).and_return(stub_model(User, :is_admin? => true))
    render
  end

  it {assert_select "a", :text => "Brindes"}
  it {assert_select "a", :text => "Cursos"}
  it {assert_select "a", :text => "Revendas"}
  it {assert_select "a", :text => "Contato"}
  it {assert_select "a", :text => "FAQ"}
end
