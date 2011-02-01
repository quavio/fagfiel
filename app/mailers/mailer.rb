#coding:utf-8
class Mailer < ActionMailer::Base
  default :from => "no-reply@portalimdepa.com.br"

  def user_changed user
    @user = user
    mail(:to => recipient, :subject => "Alteração em cadastro de revenda")
  end

  def recipient
    return "nicolas@quavio.com.br" if Rails.env == "development"
    return "natalie.bolzan@imdepa.com.br" if Rails.env == "production"
  end
end
