require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Redeem Freebie", %q{
  In order to redeem freebies
  As a reseller
  I want to exchange my credits for freebies
} do

  scenario "Redeeming a lower freebie price" do
    # Given I've enough credits to redeem a freebie
    user = create_user(
      :role => "r", 
      :email => "reseller@quavio.com.br", 
      :password => "123456", 
      :password_confirmation => "123456", 
      :reseller => create_reseller(:goal => 1000, :credits => 1000))
    freebie = create_freebie(:price => 1000)
    visit "/login"
    fill_in "E-mail", :with => "reseller@quavio.com.br"
    fill_in "Senha", :with => "123456"
    click_button "Entrar"

    # When I ask to redeem freebie
    visit "/freebies/#{freebie.id}"
    click_link "Resgatar"
    
    # Then my debits should increase
    user.reseller.debits.should be_eql(1000)

    # And it should send an email alerting about my redeem
    ActionMailer::Base.deliveries.size.should be_eql(1)
  end
end
