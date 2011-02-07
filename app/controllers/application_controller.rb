class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :specify_layout 
  before_filter :authenticate_user! 
  
  def require_same_user
    redirect_to root_path, :alert => t("alerts.require_same_user") if params[:id].to_i != current_user.id
  end

  def require_admin
    redirect_to root_path, :alert => t("alerts.require_admin") if current_user.role != "a"
  end

  def require_admin_or_manager
    redirect_to root_path, :alert => t("alerts.require_admin_or_manager") if current_user.role == "r"
  end

  protected 
  
  def specify_layout 
    current_user ? "default" : "devise"
  end  
end
