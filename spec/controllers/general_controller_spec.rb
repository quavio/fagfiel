require 'spec_helper'

describe GeneralController do
  login

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

end
