# coding:utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Show Purchase Expectations" do

  scenario "Show purchase expectations as admin" do
    sign_in_as_admin
    reseller = create_reseller
    seasonal_purchase1 = create_seasonal_purchase(:reseller => reseller)
    seasonal_purchase2 = create_seasonal_purchase(:reseller => reseller, :month => Date.today.month + 1)
    seasonal_purchase3 = create_seasonal_purchase(:reseller => reseller, :month => Date.today.month - 1)
    purchase_expectation1 = create_purchase_expectation(:seasonal_purchase => seasonal_purchase1)
    purchase_expectation2 = create_purchase_expectation(:seasonal_purchase => seasonal_purchase2)
    purchase_expectation3 = create_purchase_expectation(:seasonal_purchase => seasonal_purchase3)
    purchase_history = create_purchase_history(:seasonal_purchase => seasonal_purchase1, :year => Date.today.year - 1)

    click_link "Revendas"
    click_link "Previsão de compra"

    page.should have_selector("option", :count => 13)
    page.should have_selector("td", :text => purchase_expectation1.product.reference)
    page.should have_selector("td", :text => purchase_expectation1.product.brand)
    page.should have_selector("td", :text => purchase_expectation1.product.group)
    page.should have_selector("td", :text => purchase_expectation1.quantity.to_s)
    page.should have_selector("td", :text => purchase_history.consulted.to_s)
    page.should have_selector("td", :text => purchase_history.bought.to_s)
    page.should_not have_selector("td", :text => purchase_expectation2.product.reference)
    page.should_not have_selector("td", :text => purchase_expectation3.product.reference)
  end

  scenario "Show purchase expectations as admin when there is no expectations" do
    sign_in_as_admin
    reseller = create_reseller

    click_link "Revendas"
    click_link "Previsão de compra"

    page.should have_selector(".no_item", :text => "A #{reseller.name} ainda não tem previsão de compra para #{I18n.l(Date.today, :format => :month_and_year)}.")
  end
end
