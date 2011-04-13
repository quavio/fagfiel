class Course < ActiveRecord::Base
  def self.active
    where('start_at > ?', Date.today)
  end
end
