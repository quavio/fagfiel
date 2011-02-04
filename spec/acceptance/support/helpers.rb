module HelperMethods
  # Put helper methods you need to be available in all tests here.
  def login email, password
    visit "/login"
    fill_in "E-mail", :with => email
    fill_in "Senha", :with => password
    click_button "Entrar"
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
