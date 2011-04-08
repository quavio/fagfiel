require 'spec_helper'

describe ERP::User do
  it "should import erp users from file with suitable field mappings" do
    map = {
      'codigo' => 'erp_id',
      'cnpj' => 'client_cnpj',
      'email' => 'email',
      'nome' => 'name'
    }
    ERP::User.pg_copy_from(File.open("#{Rails.root}/spec/fixtures/users.csv", 'r'), {
      :delimiter => ';', 
      :map => map
    })
    at = ERP::User.first.attributes
    at.delete 'id'
    at.delete 'created_at'
    at.delete 'updated_at'
    at.should == {
      'erp_id' => '000458', 
      'client_cnpj' => '80238439000196',
      'email' => 'bartell@imdepa.com.br', 
      'name' => 'JBARTELL'
    }
  end
end
