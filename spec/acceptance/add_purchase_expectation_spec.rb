# coding:utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Add purchase expectation" do
  scenario "reseller is signed in" do
    sign_in_as_reseller
    product = create_product
    
    click_link "Previsão de compra"
    fill_in "Produto", :with => product.id
    fill_in "Quantidade", :with => 10
    click_button "Adicionar previsão"

    page.should have_selector("td", :text => product.reference)
    page.should have_selector("td", :text => 10.to_s)
  end

  scenario "admin is signed in" do
    sign_in_as_admin
    reseller = create_reseller

    click_link "Revendas"
    click_link "Previsão de compra"

    page.should_not have_selector("#new_seasonal_purchase_expectation")
  end

  scenario "manager is signed in" do
    manager = sign_in_as_manager
    reseller = create_reseller :manager => manager

    click_link "Revendas"
    click_link "Previsão de compra"

    page.should_not have_selector("#new_seasonal_purchase_expectation")
  end
end
