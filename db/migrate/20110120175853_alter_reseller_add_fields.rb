class AlterResellerAddFields < ActiveRecord::Migration
  def self.up
    add_column :resellers, :goal,    :numeric
    add_column :resellers, :credits, :numeric, :null => false, :default => 0
    add_column :resellers, :debits,  :numeric, :null => false, :default => 0
  end

  def self.down
    remove_column :resellers, :goal
    remove_column :resellers, :credits
    remove_column :resellers, :debits
  end
end
