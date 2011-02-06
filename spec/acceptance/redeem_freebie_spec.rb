require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Redeem freebie" do

  background do
    ActionMailer::Base.deliveries.clear
  end

  scenario "Enough credits" do
    user = create_user(
      :role => "r", 
      :email => "reseller@quavio.com.br", 
      :password => "123456", 
      :password_confirmation => "123456") 
    create_reseller(:goal => 1000, :credits => 1000, :user => user)
    freebie = create_freebie(:price => 1000)
    sign_in "reseller@quavio.com.br", "123456"

    visit "/freebies/#{freebie.id}"
    click_button "Resgatar"
    
    user.reseller.debits.should be_==(1000)
    user.reseller.orders.size.should be_== 1
    ActionMailer::Base.deliveries.last.subject.should be_==("Novo resgate de brinde")
  end

  scenario "Not enough credits" do
    user = create_user(
      :role => "r", 
      :email => "reseller@quavio.com.br", 
      :password => "123456", 
      :password_confirmation => "123456")
    reseller = create_reseller(:user => user, :credits => 0)
    freebie = create_freebie(:price => 1000)
    sign_in "reseller@quavio.com.br", "123456"

    visit "/freebies/#{freebie.id}"
    click_button "Resgatar"

    user.reseller.debits.should be_==(0)
    user.reseller.orders.size.should be_== 0
    ActionMailer::Base.deliveries.size.should be_== 0
  end
end
