class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :code, :null => false
      t.text :reference, :null => false
      t.text :brand
      t.text :group

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
