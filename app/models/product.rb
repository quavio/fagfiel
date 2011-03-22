class Product < ActiveRecord::Base
  has_many :purchase_expectations
end
