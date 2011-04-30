class Freebie < ActiveRecord::Base
  has_many :orders
  has_attached_file :image, :styles => { :normal => "80x80#" }
  validates_presence_of :title
  validates_presence_of :price
  validates_numericality_of :price

  def is_course?
    course
  end
end
