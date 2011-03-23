require 'spec_helper'

describe PurchaseExpectation do
  describe "history" do  
    
    subject{create_purchase_expectation}

    context "when there is a corresponding purchase history" do
      before :each do
        @purchase_history = create_purchase_history(:product => subject.product, :reseller => subject.reseller, :year => subject.year - 1, :month => subject.month)
      end
      its(:history){should == @purchase_history}
    end
    
    context "when there is no corresponding purchase history" do
      its(:history){should be_nil}
    end

  end
end
