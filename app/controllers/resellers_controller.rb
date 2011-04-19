class ResellersController < ApplicationController
  inherit_resources
  actions :index, :edit, :update
  before_filter :require_admin, :only => [:edit, :update]
  before_filter :require_admin_or_manager

  def index
    @resellers = Reseller.all if current_user.role == "a"
    @resellers = current_user.resellers if current_user.role == "m"
    @resellers.sort!{|a,b| a.goal_percentage <=> b.goal_percentage}
  end

  def update
    @reseller = Reseller.find(params[:id])

    respond_to do |format|
      if @reseller.update_attributes(params[:reseller])
        format.html { redirect_to resellers_path, :notice => t("notices.resellers.update", :reseller => @reseller.name) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reseller.errors, :status => :unprocessable_entity }
      end
    end
  end
end
