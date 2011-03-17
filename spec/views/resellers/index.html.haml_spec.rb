# encoding: utf-8
require 'spec_helper'

describe "resellers/index.html.haml" do
  context "manager is loged in" do
    [{:goal => 100, :credits => 0}, {:goal => 100, :credits => 100}, {:goal => 100, :credits => 1000}].each do |fields|
      percentage = (fields[:credits] / fields[:goal] * 100)
      it "should render the goal percentage #{percentage}" do
        assign(:resellers, [create_reseller(fields)])
        render
        assert_select('.reseller', 1) do |r|
          assert_select('.progress_bar', 1) do |progress_bar|
            progress_bar.first.to_s.should match /width: #{(percentage > 100 ? 100 : (percentage < 10 ? 10 : percentage))}%/
          end
          assert_select('span.ui-label b', 1) do |value|
            value.first.should match /#{percentage}%/
          end
        end
      end
    end
  end
end

