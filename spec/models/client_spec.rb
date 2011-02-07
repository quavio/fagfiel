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
      'faturamento_cliente' => 'expenditure'
    }
    ERP::Client.pg_copy_from(File.open("#{Rails.root}/spec/fixtures/cliente.csv", 'r'), :delimiter => ';', :map => map)
    at = ERP::Client.first.attributes
    at.delete 'id'
    at.delete 'created_at'
    at.delete 'updated_at'
    assert_equal({'erp_id' => '000001', 'name' => 'IMDEPA ROLAMENTOS', 'phone' => '3000-9000', 'mail' => 'cliente@cliente.com', 'manager_id' => '555555', 'vendor' => '444444', 'expenditure' => '000000000012324'}, at)
  end
end
