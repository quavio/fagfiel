require 'spec_helper'

describe "orders/index" do
  before :each do
    assign(:orders, [stub_model(Order, :reseller => stub_model(Reseller, :name => "Quavio"), :freebie => stub_model(Freebie, :title => "Mochila"), :created_at => Time.now)])
    render
  end

  it{assert_select "input.confirm_button"}
end
