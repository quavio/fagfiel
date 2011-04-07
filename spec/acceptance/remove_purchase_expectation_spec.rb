# coding:utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Remove Purchase Expectation", %q{
  In order to keep my expectations up to date
  As a reseller
  I want to remove undesired expectations
} do

  scenario "Reseller is logged in" do
    user = create_user :role => "r", :password => "123456"
    reseller = create_reseller :user => user
    product = create_product
    sign_in user.email, "123456"
    seasonal_purchase = create_seasonal_purchase :reseller => reseller, :product => product
    seasonal_purchase_expectation = create_purchase_expectation :seasonal_purchase => seasonal_purchase

    click_link "Previsão de compra"
    click_link "Remover"

    page.should have_selector("h1")
    page.should_not have_selector("td", :text => product.reference)
  end
end
