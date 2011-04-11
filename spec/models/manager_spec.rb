require 'spec_helper'

describe ERP::Manager do
  before(:each) do
    ERP::Manager.connection.execute "TRUNCATE erp.managers CASCADE;"
    ERP::Client.connection.execute "TRUNCATE erp.clients CASCADE;"
  end

  it "should import erp users twice using different import_id" do
    ERP::Manager.load_from_file("#{Rails.root}/spec/fixtures/users.csv", ERP::Import.create.id)
    count = ERP::Manager.count
    ERP::Manager.load_from_file("#{Rails.root}/spec/fixtures/users.csv", ERP::Import.create.id)
    ERP::Manager.count.should == (count * 2)
  end

  it "should import erp users from file with suitable field mappings" do
    import_id = ERP::Import.create.id
    ERP::Manager.load_from_file("#{Rails.root}/spec/fixtures/users.csv", import_id)
    at = ERP::Manager.first.attributes
    at.delete 'id'
    at.delete 'created_at'
    at.delete 'updated_at'
    at.should == {
      'erp_id' => '000458', 
      'client_cnpj' => '80238439000196',
      'email' => 'bartell@imdepa.com.br', 
      'name' => 'JBARTELL',
      'import_id' => import_id
    }
  end

  it "should transfer data from erp.users to public.users" do
    import_id = ERP::Import.create.id
    ERP::Manager.create!({
      'erp_id' => '000458', 
      'client_cnpj' => '80238439000196',
      'email' => 'bartell@imdepa.com.br', 
      'name' => 'JBARTELL',
      'import_id' => import_id
    })
    ERP::Manager.update_managers import_id
    u = ERP::Manager.first
    u.email.should == 'bartell@imdepa.com.br'
    u.name.should == 'JBARTELL'
    u.import_id.should == import_id
  end
end
