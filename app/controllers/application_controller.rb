class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :specify_layout 
#  before_filter :authenticate_user! 
  
  protected 
  
  def specify_layout 
    current_user ? "default" : "devise"
  end  
end
