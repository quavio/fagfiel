require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Ship Order", %q{
  In order to organize the shipped orders
  As a admin
  I want to ship an order
} do

  scenario "" do
    sign_in_as_admin
    reseller = create_reseller
    freebie = create_freebie
    order = create_order :reseller => reseller, :freebie => freebie

    click_link "Resgates"
    click_button "Enviado"

    order.reload
    order.should be_delivered
    page.should have_selector("p.notice", :text => "Resgate marcado como enviado.")
    page.should have_selector("span", :text => "Enviado")
  end
end
