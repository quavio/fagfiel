require 'spec_helper'

describe "seasonal_purchase_histories/index" do
  context "when there is a history" do
    it "shows consulted and bought history" do
      assign(:seasonal_purchase_history, create_purchase_history(:consulted => 20, :bought => 10))
      render
      assert_match "Ano passado: consultou 20, comprou 10", rendered
    end
  end

  context "when there is no history" do
    it "shows 0 consulted and 0 bought" do
      render
      assert_match "Ano passado: consultou 0, comprou 0", rendered
    end
  end
end

