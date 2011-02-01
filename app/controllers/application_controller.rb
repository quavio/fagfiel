class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :specify_layout 
  before_filter :authenticate_user! 
  
  def require_same_user
    if params[:id].to_i != current_user.id
      redirect_to root_path
    end
  end

  protected 
  
  def specify_layout 
    current_user ? "default" : "devise"
  end  
end
