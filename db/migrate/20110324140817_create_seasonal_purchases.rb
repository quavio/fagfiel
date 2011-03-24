require 'sexy_pg_constraints'
class CreateSeasonalPurchases < ActiveRecord::Migration
  def self.up
    create_table :seasonal_purchases do |t|
      t.integer :reseller_id, :null => false
      t.integer :product_id, :null => false
      t.integer :month, :null => false

      t.timestamps
    end
    constrain :seasonal_purchases do |t|
      t.month :within => 1..12
      t[:reseller_id, :product_id, :month].all :unique => true
    end
  end

  def self.down
    drop_table :seasonal_purchases
  end
end
