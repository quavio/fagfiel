module HelperMethods
  def sign_in email, password
    visit "/login"
    fill_in "E-mail", :with => email
    fill_in "Senha", :with => password
    click_button "Entrar"
  end

  def sign_in_as_admin
    user = create_user(
      :role => "a",
      :email => "admin@quavio.com.br",
      :password => "123456",
      :password_confirmation => "123456")
    sign_in user.email, "123456"
    user
  end

  def sign_in_as_reseller
    user = create_user(
      :role => "r",
      :email => "reseller@quavio.com.br",
      :password => "123456",
      :password_confirmation => "123456")
    create_reseller :user => user
    sign_in user.email, "123456"
    user
  end

  def sign_in_as_manager
    user = create_user(
      :role => "m",
      :email => "manager@quavio.com.br",
      :password => "123456",
      :password_confirmation => "123456")
    sign_in user.email, "123456"
    user
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
