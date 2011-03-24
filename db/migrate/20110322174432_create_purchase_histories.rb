class CreatePurchaseHistories < ActiveRecord::Migration
  def self.up
    create_table :purchase_histories do |t|
      t.integer :product_id
      t.integer :reseller_id
      t.integer :year
      t.integer :month
      t.integer :consulted
      t.integer :bought

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_histories
  end
end
