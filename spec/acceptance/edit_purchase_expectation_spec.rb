# coding:utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Edit Purchase Expectation", %q{
  In order to keep my expectations up to date
  As a reseller
  I want to edit my expectations
} do

  scenario "Logged in as reseller" do
    sign_in_as_reseller
    product = create_product

    click_link "Previsão de compra"
    fill_in "Produto", :with => product.reference
    fill_in "Quantidade", :with => 10
    click_button "Adicionar previsão"
    click_link "Editar"
    fill_in "Quantidade", :with => 20
    click_button "Salvar"

    page.should have_selector("td", :text => product.reference)
    page.should have_selector("td", :text => 20.to_s)
  end
end
