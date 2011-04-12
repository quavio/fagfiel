require 'sexy_pg_constraints'
class AlterUserAddUniqueErpId < ActiveRecord::Migration
  def self.up
    constrain :users do |t|
      t.erp_id :unique => true
    end
  end

  def self.down
    deconstrain :users do |t|
      t.erp_id :unique
    end
  end
end
