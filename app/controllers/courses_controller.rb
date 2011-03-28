class CoursesController < ApplicationController
  inherit_resources
  actions :index
  has_scope :active, :type => :boolean, :default => true
end
