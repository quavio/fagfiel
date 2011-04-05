class CoursesController < ApplicationController
  inherit_resources
  actions :all
  has_scope :active, :type => :boolean, :default => true
end
