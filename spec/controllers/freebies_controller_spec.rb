require 'spec_helper'

describe FreebiesController do
  login

  it "should present a list of freebies in index" do
    get :index
    response.should be_success
  end
end
