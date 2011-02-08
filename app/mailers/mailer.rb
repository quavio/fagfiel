#coding:utf-8
class Mailer < ActionMailer::Base
  default :from => "no-reply@portalimdepa.com.br"
  layout 'mailer'

  def user_changed user
    @user = user
    mail(:to => recipient, :subject => "Alteração em cadastro de revenda")
  end

  def new_order order
    @order = order
    mail(:to => recipient, :subject => "Novo resgate de brinde")
  end

  def contact user, message
    @user = user
    @message = message
    mail(:to => recipient, :subject => "Contato através do Portal Fag Fiel")
  end

  def recipient
    return "nicolas@quavio.com.br" if Rails.env == "development"
    return "natalie.bolzan@imdepa.com.br" if Rails.env == "production"
  end
end
