class CreateErpUsers < ActiveRecord::Migration
  def self.up
    execute "SET search_path TO erp,public;"
    create_table :users do |t|
      t.text :erp_id
      t.text :client_cnpj
      t.text :email
      t.text :name
      t.timestamps
    end
    execute "SET search_path TO public, erp;"
  end

  def self.down
    drop_table :users
  end
end
