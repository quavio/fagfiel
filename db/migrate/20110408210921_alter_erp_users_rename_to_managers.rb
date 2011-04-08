class AlterErpUsersRenameToManagers < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE erp.users RENAME TO managers"
  end

  def self.down
    execute "ALTER TABLE erp.managers RENAME TO users"
  end
end
