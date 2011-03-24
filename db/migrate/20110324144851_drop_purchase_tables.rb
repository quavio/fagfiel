class DropPurchaseTables < ActiveRecord::Migration
  def self.up
    drop_table :purchase_histories
    drop_table :purchase_expectations
  end

  def self.down
    create_table :purchase_histories do |t|
      t.integer :product_id
      t.integer :reseller_id
      t.integer :year
      t.integer :month
      t.integer :consulted
      t.integer :bought

      t.timestamps
    end
    create_table :purchase_expectations do |t|
      t.integer :product_id, :null => false
      t.integer :reseller_id, :null => false
      t.integer :year, :null => false
      t.integer :month, :null => false
      t.integer :quantity, :null => false, :default => 0

      t.timestamps
    end
  end
end
