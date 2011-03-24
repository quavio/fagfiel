class Product < ActiveRecord::Base
  has_many :purchase_expectations
  has_many :purchase_histories
end
