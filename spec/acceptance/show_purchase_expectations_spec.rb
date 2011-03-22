# coding:utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Show Purchase Expectations" do

  scenario "Show purchase expectations as admin" do
    sign_in_as_admin
    reseller = create_reseller
    purchase_expectation1 = create_purchase_expectation(:reseller => reseller)
    purchase_expectation2 = create_purchase_expectation(:reseller => reseller, :date => Date.today + 1.month)
    purchase_expectation3 = create_purchase_expectation(:reseller => reseller, :date => Date.today - 1.month)
    purchase_expectation4 = create_purchase_expectation(:reseller => reseller, :date => Date.today - 1.year)

    click_link "Revendas"
    click_link "Previsão de compra"

    page.should have_selector("option", :count => 13)
    page.should have_selector("td", :text => purchase_expectation1.product.reference)
    page.should have_selector("td", :text => purchase_expectation1.product.brand)
    page.should have_selector("td", :text => purchase_expectation1.product.group)
    page.should have_selector("td", :text => purchase_expectation1.quantity.to_s)
    page.should_not have_selector("td", :text => purchase_expectation2.product.reference)
    page.should_not have_selector("td", :text => purchase_expectation3.product.reference)
  end

  scenario "Show purchase expectations as admin when there is no expectations" do
    sign_in_as_admin
    reseller = create_reseller

    click_link "Revendas"
    click_link "Previsão de compra"

    page.should have_selector(".no_items", :text => "A #{reseller.name} ainda não tem previsão de compra para #{I18n.l(Date.today, :format => :month_and_year)}.")
  end
end
