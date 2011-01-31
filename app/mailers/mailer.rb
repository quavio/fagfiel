class Mailer < ActionMailer::Base
  default :from => "from@example.com"

  def user_changed user
    mail(:to => "nicolas@quavio.com.br", :subject => "Cadastro de revenda alterado")
  end
end
