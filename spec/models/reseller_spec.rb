require 'spec_helper'

describe Reseller do
  let(:manager){ create_user }
  let(:user){ create_user }
  subject{ create_reseller :manager => manager, :user => user }
  its(:manager){ should == manager }
  its(:user){ should == user }
  its(:user){ should_not == manager }
  
  it "should not allow user and manager to reference the same user" do
    r = create_reseller :user => user, :manager => user
    r.should_not be_valid
  end

  describe "#debits" do
    context "when no order is done" do
      subject{create_reseller}
      its(:debits){should be_eql 0}
    end

    context "when there is 2000 in orders" do
      subject{
        reseller = create_reseller(:credits => 2000)
        create_order(:freebie => create_freebie(:price => 1500), :reseller => reseller)
        create_order(:freebie => create_freebie(:price => 500), :reseller => reseller)
        reseller.reload
      }

      its(:debits){should be_== 2000}
    end
  end

  describe "#balance" do
    context "when credit and debit are equal" do
      subject{
        reseller = create_reseller
        reseller.stub(:credits).and_return(1000)
        reseller.stub(:debits).and_return(1000)
        reseller
      }
      its(:balance){should be_eql 0}
    end

    context "when credit = 1000 and debit = 500" do
      subject{
        reseller = create_reseller
        reseller.stub(:credits).and_return(1000)
        reseller.stub(:debits).and_return(500)
        reseller
      }
      its(:balance){should be_eql 500}
    end
  end
end
