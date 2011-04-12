require 'spec_helper'

describe OrdersController do
  let(:user){create_user(:role => "a")}
  let(:reseller){create_reseller(:credits => 2000)}
  let(:order){create_order(:reseller => reseller)}
  before :each do; sign_in user; end

  describe "PUT update" do
    before :each do; put "update", :id => order.id, :order => {:delivered => true}; end
    it{should assign_to(:order).with(order)}

    it "should update order" do
      order.reload
      order.should be_delivered
    end

  end
end
