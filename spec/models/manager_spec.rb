require 'spec_helper'

describe ERP::Manager do
  before(:each) do
    ERP::Manager.connection.execute "TRUNCATE erp.managers CASCADE;"
    ERP::Client.connection.execute "TRUNCATE erp.clients CASCADE;"
    @import_id = ERP::Import.create.id
  end

  it "should import erp users twice using different import_id" do
    ERP::Manager.load_from_file("#{Rails.root}/spec/fixtures/managers.csv", ERP::Import.create.id)
    count = ERP::Manager.count
    ERP::Manager.load_from_file("#{Rails.root}/spec/fixtures/managers.csv", ERP::Import.create.id)
    ERP::Manager.count.should == (count * 2)
  end

  it "should import erp users from file with suitable field mappings" do
    ERP::Manager.load_from_file("#{Rails.root}/spec/fixtures/managers.csv", @import_id)
    at = ERP::Manager.first.attributes
    at.delete 'id'
    at.delete 'created_at'
    at.delete 'updated_at'
    at.should == {
      'erp_id' => '000458', 
      'client_cnpj' => '80238439000196',
      'email' => 'bartell@imdepa.com.br', 
      'name' => 'JBARTELL',
      'import_id' => @import_id
    }
  end

  context "when we have one manager in ERP::Manager" do
    before(:each) do
      ERP::Manager.create!({
        'erp_id' => '000458', 
        'client_cnpj' => '80238439000196',
        'email' => 'bartell@imdepa.com.br', 
        'name' => 'JBARTELL',
        'import_id' => @import_id
      })
    end
    it "should not transfer data from erp.users to public.users when we pass a non-existing import_id" do
      ERP::Manager.import @import_id + 1
      User.all.should be_empty
    end

    it "should transfer data from erp.users to public.users when we pass the right import_id" do
      ERP::Manager.import @import_id
      u = User.first
      u.email.should == 'bartell@imdepa.com.br'
      u.name.should == 'JBARTELL'
      u.erp_id.should == '000458'
    end

    context "when we update an already imported manager" do
      before(:each) do
        ERP::Manager.import @import_id
        ERP::Manager.first.update_attributes :name => 'updated name', :email => 'updated_email@gmail.com'
      end

      it "should not update managers based on a non-existing import_id" do
        ERP::Manager.import @import_id + 1
        u = User.first
        u.email.should == 'bartell@imdepa.com.br'
        u.name.should == 'JBARTELL'
      end

      it "should update managers" do
        ERP::Manager.import @import_id
        u = User.first
        u.name.should == 'updated name'
        u.email.should == 'updated_email@gmail.com'
      end
    end
  end
end
