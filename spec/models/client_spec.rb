require 'spec_helper'

describe ERP::Client do
  before(:each) do
    ERP::Manager.connection.execute "TRUNCATE erp.managers CASCADE;"
    ERP::Client.connection.execute "TRUNCATE erp.clients CASCADE;"
    @import_id = ERP::Import.create.id
  end

  it "should import erp clients twice using different import_id" do
    ERP::Client.load_from_file("#{Rails.root}/spec/fixtures/managers.csv", ERP::Import.create.id)
    count = ERP::Client.count
    ERP::Client.load_from_file("#{Rails.root}/spec/fixtures/managers.csv", ERP::Import.create.id)
    ERP::Client.count.should == (count * 2)
  end

  it "should import clients from file with suitable field mappings" do
    ERP::Client.load_from_file "#{Rails.root}/spec/fixtures/clients.csv", @import_id
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
      'import_id' => @import_id
    }
  end

  context "when we have on record in ERP::Manager and ERP::Client" do
    before(:each) do
      ERP::Manager.create!({
        'erp_id' => '000467', 
        'client_cnpj' => '80238439000196',
        'email' => 'bartell@imdepa.com.br', 
        'name' => 'JBARTELL',
        'import_id' => @import_id
      })
      ERP::Client.create!({
        'erp_id' => '005851', 
        'name' => 'EMTECO COM E REPRES LTDA                ', 
        'phone' => '36712236       ', 
        'mail' => 'emtecocb@hotmail.com                                        ', 
        'manager_id' => '000467', 
        'vendor' => '000097', 
        'expenditure' => '000000000022400',
        'cnpj' => '55447189000157',
        'import_id' => @import_id
      })
    end

    it "should not transfer data from clients to reseller when we pass a non-existing import_id" do
      ERP::Client.import @import_id + 1
      User.all.should be_empty
      Reseller.all.should be_empty
    end

    it "should transfer data from clients to reseller when we pass the right import_id" do
      ERP::Client.import @import_id
      r = Reseller.first
      r.name.should == 'EMTECO COM E REPRES LTDA'
      r.phone.should == '36712236'
      r.month_expenditure.should == 22400
        r.credits.should == 2
      r.user.email.should == 'emtecocb@hotmail.com'
      r.user.role.should == 'r'
      r.user.erp_id.should == '005851'
    end

    context "when we update an already imported client" do
      before(:each) do
        ERP::Client.import @import_id
        ERP::Client.first.update_attributes({
          :name => 'updated name', 
          :phone => '999', 
          :mail => 'updated_email@gmail.com',
          :expenditure => '1'
        })
      end

      it "should update reseller" do
        ERP::Client.import @import_id
        r = Reseller.first
        r.name.should == 'updated name'
        r.phone.should == '999'
        # credits should always accumulate the expenditure 
        # unless current year > year from updated_at
        r.month_expenditure.should == 22401
        r.credits.should == 2
        r.user.email.should == 'updated_email@gmail.com'
        r.user.role.should == 'r'
      end

      it "should not update reseller based on a non-existing import_id" do
        ERP::Client.import @import_id + 1
        r = Reseller.first
        r.name.should == 'EMTECO COM E REPRES LTDA'
        r.phone.should == '36712236'
        r.month_expenditure.should == 22400
        r.credits.should == 2
        r.user.email.should == 'emtecocb@hotmail.com'
      end
      
      context "when the last update was in the previous year" do
        before(:each) do
          Reseller.first.update_attribute :updated_at, Time.now - 1.month
        end

        it "should reset credits to imported expenditure" do
          ERP::Client.import @import_id
          r = Reseller.first
          r.month_expenditure.should == 1
          r.credits.should == 2
        end
      end
    end
  end
end
