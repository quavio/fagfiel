class Freebie < ActiveRecord::Base
  has_many :orders
  has_attached_file :image, :styles => { :normal => "80x80#" }
end
