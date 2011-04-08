require 'spec_helper'

describe ERP::User do
  it "should import clients from file with suitable field mappings" do
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
      'erp_id' => '000001', 
      'client_cnpj' => '99999999999999',
      'email' => 'vendedor@gerente.com', 
      'name' => 'JOAO DA SILVA'
    }
  end
end
