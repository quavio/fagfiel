require 'spec_helper'

describe ERP::Client do
  it "should import clients from file with suitable field mappings" do
    map = {
      'codigo_cliente' => 'erp_id',
      'nome_cliente' => 'name',
      'telefone_cliente' => 'phone',
      'mail_cliente' => 'mail',
      'gerente_cliente' => 'manager_id',
      'vendedor_cliente' => 'vendor',
      'faturamento_cliente' => 'expenditure',
      'cnpj_cliente' => 'cnpj'
    }
    ERP::Client.pg_copy_from(File.open("#{Rails.root}/spec/fixtures/cliente.csv", 'r'), {
      :delimiter => ';', 
      :map => map
    })
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
end
