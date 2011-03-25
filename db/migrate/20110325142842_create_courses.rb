class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.text :title, :null => false
      t.text :description
      t.decimal :price, :null => false, :default => 0
      t.date :start_at
      t.integer :max_attendants
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
