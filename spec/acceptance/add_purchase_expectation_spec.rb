# coding:utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Add purchase expectation" do
  scenario "reseller is signed in" do
    sign_in_as_reseller
    product = create_product
    
    click_link "Previsão de compra"
    fill_in "Produto", :with => product.reference
    fill_in "Quantidade", :with => 10
    click_button "Adicionar previsão"

    page.should have_selector("td", :text => product.reference)
    page.should have_selector("td", :text => 10.to_s)
  end

  scenario "adding without product reference" do
    sign_in_as_reseller

    click_link "Previsão de compra"
    click_button "Adicionar previsão"

    page.should have_selector("p.alert", :text => "Produto não existe")
  end

  scenario "adding same expectations twice" do
    user = create_user(:role => "r", :password => "123456")
    reseller = create_reseller(:user => user)
    product = create_product
    seasonal_purchase = create_seasonal_purchase :product => product, :reseller => reseller, :month => Date.today.month
    seasonal_purchase_expectation = create_purchase_expectation :seasonal_purchase => seasonal_purchase, :year => Date.today.year
    sign_in user.email, "123456"

    click_link "Previsão de compra"
    fill_in "Produto", :with => product.reference
    fill_in "Quantidade", :with => 10
    click_button "Adicionar previsão"

    page.should have_selector("p.alert", :text => "Já existe uma previsão de compra do produto #{product.reference} para este mês")
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
