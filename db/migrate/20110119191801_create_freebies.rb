require 'sexy_pg_constraints'
class CreateFreebies < ActiveRecord::Migration
  def self.up
    create_table :freebies do |t|
      t.text :title, :null => false
      t.text :description
      t.decimal :price, :null => false, :default => 0
      t.boolean :active, :null => false, :default => 'true'
      t.timestamps
    end
    execute "CREATE UNIQUE INDEX freebies_title_active_key ON freebies (title) WHERE active;"
  end

  def self.down
    drop_table :freebies
  end
end
