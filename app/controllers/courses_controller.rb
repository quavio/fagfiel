class CoursesController < ApplicationController
  inherit_resources
  actions :index, :new, :edit
  has_scope :active, :type => :boolean, :default => true
end
