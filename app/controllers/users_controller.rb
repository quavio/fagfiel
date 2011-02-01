#coding:utf-8
class UsersController < ApplicationController
  inherit_resources
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'

  before_filter :require_same_user, :only => [:edit, :update]

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) and params[:user].delete(:password_confirmation) if params[:user][:password].empty?
    @params = params[:user]

    respond_to do |format|
      if @user.update_attributes(@params)
        Mailer.user_changed(@user).deliver
        format.html { redirect_to edit_user_path(@user), :notice => 'Usuário alterado com sucesso.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end
end
