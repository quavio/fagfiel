class AddSchemaErpImports < ActiveRecord::Migration
  def self.up
    execute "
    CREATE SCHEMA erp;
    ALTER DATABASE portal_inafag_#{Rails.env} SET search_path TO public, erp;
    "
  end

  def self.down
    execute "
    ALTER DATABASE portal_inafag_#{Rails.env} SET search_path TO public;
    DROP SCHEMA erp CASCADE;
    "
  end
end
