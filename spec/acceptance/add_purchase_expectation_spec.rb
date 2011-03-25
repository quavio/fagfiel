# coding:utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Add purchase expectation" do
  scenario "reseller is loged in" do
    sign_in_as_reseller
    product = create_product
    
    click_link "Previsão de compra"
    fill_in "Produto", :with => product.id
    fill_in "Quantidade", :with => 10
    click_button "Adicionar previsão"

    page.should have_selector("td", :text => product.reference)
  end
end
