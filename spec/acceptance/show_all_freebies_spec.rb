# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Show All Freebies" do
  scenario "Show all as reseller" do
    user = create_user :role => "r", :password => "123456", :password_confirmation => "123456", :email => "revenda@quavio.com.br"
    reseller = create_reseller :user => user, :credits => 1000
    sign_in "revenda@quavio.com.br", "123456"

    click_link "Brindes"
    
    within(:css, ".submenu") do
      page.should have_selector("span.big", :text => "1000")
    end    
  end
end
