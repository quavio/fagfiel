class AlterErpClientsAddCnpj < ActiveRecord::Migration
  def self.up
    add_column 'erp.clients', :cnpj, :text
  end

  def self.down
    remove_column 'erp.clients', :cnpj
  end
end
