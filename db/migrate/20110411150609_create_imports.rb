class CreateImports < ActiveRecord::Migration
  def self.up
    execute "SET search_path TO erp, public;"
    create_table :imports do |t|
      t.timestamps
    end
    execute "SET search_path TO public, erp;"
  end

  def self.down
    drop_table :imports
  end
end
