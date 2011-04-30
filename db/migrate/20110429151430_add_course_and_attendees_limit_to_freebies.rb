class AddCourseAndAttendeesLimitToFreebies < ActiveRecord::Migration
  def self.up
    add_column :freebies, :course, :boolean
    add_column :freebies, :attendees_limit, :integer
  end

  def self.down
    remove_column :freebies, :attendees_limit
    remove_column :freebies, :course
  end
end
