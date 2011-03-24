require 'spec_helper'

describe SeasonalPurchaseExpectation do
  describe "history" do  

    subject{create_purchase_expectation}

    context "when there is a corresponding purchase history" do
      before :each do
        @purchase_history = create_purchase_history(:seasonal_purchase => subject.seasonal_purchase, :year => subject.year - 1)
      end
      its(:history){should == @purchase_history}
    end

    context "when there is no corresponding purchase history" do
      its(:history){should be_nil}
    end

  end
end
