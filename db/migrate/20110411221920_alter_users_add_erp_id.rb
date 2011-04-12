class AlterUsersAddErpId < ActiveRecord::Migration
  def self.up
    add_column :users, :erp_id, :text
  end

  def self.down
    remove_column :users, :erp_id, :text
  end
end
