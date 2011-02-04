require 'spec_helper'

describe Order do
  describe ".create" do
    subject{create_order}

    it "should set price from freebie price" do
      subject.price.should be_== subject.freebie.price
    end

    context "when reseller does not have sufficient funds" do
      subject{create_order(
        :reseller => create_reseller(:credits => 0), 
        :freebie => create_freebie(:price => 1000))}

        its(:errors){should_not be_empty}
    end

    context "when reseller have sufficient funds" do
      subject{create_order(
        :reseller => create_reseller(:credits => 1000), 
        :freebie => create_freebie(:price => 1000))}

        its(:errors){should be_empty}
    end

  end
end
