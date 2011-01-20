require 'sexy_pg_constraints'
class CreateResellers < ActiveRecord::Migration
  def self.up
    create_table :resellers do |t|
      t.integer :user_id, :null => false
      t.integer :manager_id, :null => false
      t.text :name, :null => false
      t.text :phone
      t.timestamps
    end
    constrain :resellers do |t|
      t.user_id :reference => {:users => :id}, :unique => true
      t.manager_id :reference => {:users => :id}
    end
    execute "ALTER TABLE resellers ADD CHECK (user_id <> manager_id);"
  end

  def self.down
    drop_table :resellers
  end
end
