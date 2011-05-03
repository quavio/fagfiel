require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Download Documents" do
  scenario "when reseller is logged in" do
    user = create_user(:role => "r", :email => "reseller@quavio.com.br", :password => "123456", :password_confirmation => "123456") 
    create_reseller(:user => user)
    sign_in "reseller@quavio.com.br", "123456"

    click_link "Documentos"
    
    page.should have_selector("h1", :text => "Documentos para download")
  end
end
