require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Redeem Freebie", %q{
  In order to redeem freebies
  As a reseller
  I want to exchange my credits for freebies
} do

  background do
    ActionMailer::Base.deliveries.clear
  end

  scenario "Redeeming a lower freebie price" do
    # Given I've enough credits to redeem a freebie
    user = create_user(
      :role => "r", 
      :email => "reseller@quavio.com.br", 
      :password => "123456", 
      :password_confirmation => "123456") 
    create_reseller(:goal => 1000, :credits => 1000, :user => user)
    freebie = create_freebie(:price => 1000)
    login "reseller@quavio.com.br", "123456"

    # When I ask to redeem freebie
    visit "/freebies/#{freebie.id}"
    click_button "Resgatar"
    
    # Then my debits should increase
    user.reseller.debits.should be_==(1000)
    user.reseller.orders.size.should be_== 1

    # And it should send an email alerting about my redeem
    ActionMailer::Base.deliveries.last.subject.should be_==("Novo resgate de brinde")
  end

  scenario "Redeeming a higher freebie price" do
    # Given I've not enough credits to redeem a freebie
    user = create_user(
      :role => "r", 
      :email => "reseller@quavio.com.br", 
      :password => "123456", 
      :password_confirmation => "123456")
    reseller = create_reseller(:user => user, :credits => 0)
    freebie = create_freebie(:price => 1000)
    login "reseller@quavio.com.br", "123456"

    # When I ask to redeem freebie
    visit "/freebies/#{freebie.id}"
    click_button "Resgatar"

    # Then my debits should not increase
    user.reseller.debits.should be_==(0)
    user.reseller.orders.size.should be_== 0

    # And it should not send an email alerting about my redeem
    ActionMailer::Base.deliveries.size.should be_== 0
  end
end
