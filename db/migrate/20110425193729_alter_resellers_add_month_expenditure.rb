class AlterResellersAddMonthExpenditure < ActiveRecord::Migration
  def self.up
    add_column :resellers, :month_expenditure, :numeric, :null => false, :default => 0
  end

  def self.down
    remove_column :resellers, :month_expenditure
  end
end
