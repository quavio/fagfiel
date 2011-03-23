class AddYearAndMonthToPurchaseExpectation < ActiveRecord::Migration
  def self.up
    remove_column :purchase_expectations, :date
    add_column :purchase_expectations, :year, :integer
    add_column :purchase_expectations, :month, :integer
  end

  def self.down
    add_column :purchase_expectations, :date, :date
    remove_column :purchase_expectations, :month
    remove_column :purchase_expectations, :year
  end
end
