class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :specify_layout 
  before_filter :authenticate_user! 
  
  protected 
  
  def specify_layout 
    devise_controller? ? "devise" : "default" 
  end  
end
