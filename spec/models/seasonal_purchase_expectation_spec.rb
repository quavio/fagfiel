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

  describe "last_three_months_history" do

    context "when there is no history in the past 3 months" do
      subject{create_purchase_expectation}
      its(:last_three_months_history){should be_== [nil, nil, nil]}
    end

    context "when there is history in the past 3 months" do
      let(:product){create_product}
      let(:reseller){create_reseller}
      let(:seasonal_purchase_current_month){create_seasonal_purchase :month => Date.today.month, :product => product, :reseller => reseller}
      let(:seasonal_purchase_past_1_month){create_seasonal_purchase :month => (Date.today - 1.month).month, :product => product, :reseller => reseller}
      let(:seasonal_purchase_past_2_months){create_seasonal_purchase :month => (Date.today - 2.month).month, :product => product, :reseller => reseller}
      let(:seasonal_purchase_past_3_months){create_seasonal_purchase :month => (Date.today - 3.month).month, :product => product, :reseller => reseller}
      subject{create_purchase_expectation :seasonal_purchase => seasonal_purchase_current_month}
      let(:purchase_history_past_1_month){create_purchase_history :seasonal_purchase => seasonal_purchase_past_1_month, :year => (Date.today - 1.month).year}
      let(:purchase_history_past_2_months){create_purchase_history :seasonal_purchase => seasonal_purchase_past_2_months, :year => (Date.today - 2.month).year}
      let(:purchase_history_past_3_months){create_purchase_history :seasonal_purchase => seasonal_purchase_past_3_months, :year => (Date.today - 3.month).year}
      its(:last_three_months_history){should be_== [purchase_history_past_1_month, purchase_history_past_2_months, purchase_history_past_3_months]}
    end

  end

end
