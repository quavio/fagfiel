require 'sexy_pg_constraints'
class AddImportFks < ActiveRecord::Migration
  def self.up
    execute "
    TRUNCATE erp.managers;
    TRUNCATE erp.clients;
    "
    add_column :managers, :import_id, :integer, :null => false
    add_column :clients, :import_id, :integer, :null => false
    constrain :managers do |t|
      t.import_id :reference => {:imports => :id}
    end
    constrain :clients do |t|
      t.import_id :reference => {:imports => :id}
    end
  end

  def self.down
    remove_column :managers, :import_id
    remove_column :clients, :import_id
  end
end
