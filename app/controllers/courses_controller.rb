class CoursesController < ApplicationController
  inherit_resources
  actions :all
  has_scope :active, :type => :boolean, :default => true, :if => Proc.new {|c| c.current_user.is_reseller? || c.current_user.is_manager?}
  before_filter :require_admin, :except => [:index, :show]
end
