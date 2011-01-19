require 'sexy_pg_constraints'
class AlterTableUserAddType < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :char, :null => false, :default => 'r'
    constrain :users do |t|
      t.role(:whitelist => ['a', 'm', 'r'])
    end
    execute "COMMENT ON COLUMN users.role IS 'Can be (a)dmin, (m)anager or (r)eseller'"
  end

  def self.down
    remove_column :type
  end
end
