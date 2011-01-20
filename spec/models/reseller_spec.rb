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
end
