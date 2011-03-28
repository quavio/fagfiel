class Course < ActiveRecord::Base
  def self.active
    where('start_at > current_date')
  end
end
