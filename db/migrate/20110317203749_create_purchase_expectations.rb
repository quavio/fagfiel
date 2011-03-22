class CreatePurchaseExpectations < ActiveRecord::Migration
  def self.up
    create_table :purchase_expectations do |t|
      t.integer :product_id, :null => false
      t.integer :reseller_id, :null => false
      t.date :date, :null => false
      t.integer :quantity, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_expectations
  end
end
