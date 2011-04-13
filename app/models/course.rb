class Course < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :price

  def self.active
    where('start_at > ?', Date.today)
  end
end
