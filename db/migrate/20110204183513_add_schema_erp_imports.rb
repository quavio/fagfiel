class AddSchemaErpImports < ActiveRecord::Migration
  def self.up
    execute "
    CREATE SCHEMA erp;
    ALTER DATABASE fagfiel_#{Rails.env} SET search_path TO public, erp;
    "
  end

  def self.down
    execute "
    ALTER DATABASE fagfiel_#{Rails.env} SET search_path TO public;
    DROP SCHEMA erp CASCADE;
    "
  end
end
