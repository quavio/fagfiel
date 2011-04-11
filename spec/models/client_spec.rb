require 'spec_helper'

describe ERP::Client do
  before(:each) do
    ERP::Client.destroy_all
  end

  it "should import clients from file with suitable field mappings" do
    ERP::Client.load_from_file "#{Rails.root}/spec/fixtures/clients.csv"
    at = ERP::Client.first.attributes
    at.delete 'id'
    at.delete 'created_at'
    at.delete 'updated_at'
    at.should == {
      'erp_id' => '005851', 
      'name' => 'EMTECO COM E REPRES LTDA                ', 
      'phone' => '36712236       ', 
      'mail' => 'emtecocb@hotmail.com                                        ', 
      'manager_id' => '000467', 
      'vendor' => '000097', 
      'expenditure' => '000000000022400',
      'cnpj' => '55447189000157'
    }
  end

  it "should transfer data from clients to reseller" do
    ERP::Client.create!({
      'erp_id' => '005851', 
      'name' => 'EMTECO COM E REPRES LTDA                ', 
      'phone' => '36712236       ', 
      'mail' => 'emtecocb@hotmail.com                                        ', 
      'manager_id' => '000467', 
      'vendor' => '000097', 
      'expenditure' => '000000000022400',
      'cnpj' => '55447189000157'
    })
    ERP::Client.update_resellers
    r = Reseller.first
    r.name.should == 'EMTECO COM E REPRES LTDA'
    r.phone.should == '36712236'
    r.credits.should == 22400
    r.user.email.should == 'emtecocb@hotmail.com'
    r.user.role.should == 'r'
  end
end
