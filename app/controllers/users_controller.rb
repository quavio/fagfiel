#coding:utf-8
class UsersController < ApplicationController
  inherit_resources
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        Mailer.user_changed(@user).deliver
        format.html { redirect_to(@user, :notice => 'Usuário alterado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end
end
