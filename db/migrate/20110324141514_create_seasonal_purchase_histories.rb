require 'sexy_pg_constraints'
class CreateSeasonalPurchaseHistories < ActiveRecord::Migration
  def self.up
    create_table :seasonal_purchase_histories do |t|
      t.integer :seasonal_purchase_id, :null => false
      t.integer :year, :null => false
      t.integer :consulted, :null => false, :default => 0
      t.integer :bought, :null => false, :default => 0

      t.timestamps
    end
    constrain :seasonal_purchase_histories do |t|
      t.seasonal_purchase_id :reference => {:seasonal_purchases => :id}
      t[:seasonal_purchase_id, :year].all :unique => true
      t.consulted :positive => true
      t.bought :positive => true
    end
    execute "ALTER TABLE seasonal_purchase_histories ADD CONSTRAINT year_starts_in_2000 CHECK (year >= 2000)"
  end

  def self.down
    drop_table :seasonal_purchase_histories
  end
end
