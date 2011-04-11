require 'spec_helper'

describe ERP::Client do
  before(:each) do
    ERP::Client.connection.execute "TRUNCATE erp.clients CASCADE;"
  end

  it "should import erp clients twice using different import_id" do
    ERP::Client.load_from_file("#{Rails.root}/spec/fixtures/users.csv", ERP::Import.create.id)
    count = ERP::Client.count
    ERP::Client.load_from_file("#{Rails.root}/spec/fixtures/users.csv", ERP::Import.create.id)
    ERP::Client.count.should == (count * 2)
  end

  it "should import clients from file with suitable field mappings" do
    import_id = ERP::Import.create.id
    ERP::Client.load_from_file "#{Rails.root}/spec/fixtures/clients.csv", import_id
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
      'cnpj' => '55447189000157',
      'import_id' => import_id
    }
  end

  it "should transfer data from clients to reseller" do
    import_id = ERP::Import.create.id
    ERP::Client.create!({
      'erp_id' => '005851', 
      'name' => 'EMTECO COM E REPRES LTDA                ', 
      'phone' => '36712236       ', 
      'mail' => 'emtecocb@hotmail.com                                        ', 
      'manager_id' => '000467', 
      'vendor' => '000097', 
      'expenditure' => '000000000022400',
      'cnpj' => '55447189000157',
      'import_id' => import_id
    })
    ERP::Client.update_resellers import_id
    r = Reseller.first
    r.name.should == 'EMTECO COM E REPRES LTDA'
    r.phone.should == '36712236'
    r.credits.should == 22400
    r.user.email.should == 'emtecocb@hotmail.com'
    r.user.role.should == 'r'
  end
end
