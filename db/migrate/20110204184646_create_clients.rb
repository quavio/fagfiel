class CreateClients < ActiveRecord::Migration
  def self.up
    execute "SET search_path TO erp,public;"
    create_table :clients do |t|
      t.text :erp_id
      t.text :name
      t.text :phone
      t.text :mail
      t.text :manager_id
      t.text :vendor
      t.text :expenditure
      t.timestamps
    end
    execute "SET search_path TO public, erp;"
  end

  def self.down
    drop_table :clients
  end
end
