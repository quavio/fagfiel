require 'spec_helper'

describe User do
  context "when user is admin" do
    subject { create_user :role => 'a' }
    its(:is_reseller?)  { should be_false }
    its(:is_admin?)     { should be_true }
    its(:is_manager?)   { should be_false }
  end
  context "when user is manager" do
    subject { create_user :role => 'm' }
    its(:is_reseller?)  { should be_false }
    its(:is_admin?)     { should be_false }
    its(:is_manager?)   { should be_true }
  end
  context "when user is reseller" do
    subject { create_user :role => 'r' }
    its(:is_reseller?)  { should be_true }
    its(:is_admin?)     { should be_false }
    its(:is_manager?)   { should be_false }
  end
end

