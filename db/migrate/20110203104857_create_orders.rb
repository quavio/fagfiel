class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :reseller_id
      t.integer :freebie_id
      t.boolean :delivered

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
