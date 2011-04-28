# coding:utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Show Purchase Expectations" do

  scenario "Show purchase expectations as admin" do
    sign_in_as_admin
    reseller = create_reseller
    product = create_product
    seasonal_purchase_current_month = create_seasonal_purchase(:reseller => reseller, :product => product, :month => Date.today.month)
    seasonal_purchase_next_month = create_seasonal_purchase(:reseller => reseller, :month => Date.today.month + 1)
    seasonal_purchase_past_1_month = create_seasonal_purchase(:reseller => reseller, :product => product, :month => (Date.today - 1.month).month)
    seasonal_purchase_past_2_months = create_seasonal_purchase(:reseller => reseller, :product => product, :month => (Date.today - 2.month).month)
    seasonal_purchase_past_3_months = create_seasonal_purchase(:reseller => reseller, :product => product, :month => (Date.today - 3.month).month)
    purchase_expectation_current_month = create_purchase_expectation(:seasonal_purchase => seasonal_purchase_current_month, :year => Date.today.year)
    purchase_expectation_next_month = create_purchase_expectation(:seasonal_purchase => seasonal_purchase_next_month, :year => (Date.today.month + 1).year)
    purchase_history_last_year = create_purchase_history(:seasonal_purchase => seasonal_purchase_current_month, :year => (Date.today - 1.year).year)
    purchase_history_past_1_month = create_purchase_history(:seasonal_purchase => seasonal_purchase_past_1_month, :year => (Date.today - 1.month).year)
    purchase_history_past_2_months = create_purchase_history(:seasonal_purchase => seasonal_purchase_past_2_months, :year => (Date.today - 2.month).year)
    purchase_history_past_3_months = create_purchase_history(:seasonal_purchase => seasonal_purchase_past_3_months, :year => (Date.today - 3.month).year)

    click_link "Revendas"
    click_link "Previsão de compra"

    page.should have_selector("option", :count => 13)
    page.should have_selector("td", :text => product.reference)
    page.should have_selector("td", :text => product.brand)
    page.should have_selector("td", :text => product.group)
    page.should have_selector("td", :text => purchase_expectation_current_month.quantity.to_s)
    page.should have_selector("td", :text => purchase_history_last_year.bought.to_s)
    page.should have_selector("td", :text => purchase_history_past_1_month.bought.to_s)
    page.should have_selector("td", :text => purchase_history_past_2_months.bought.to_s)
    page.should have_selector("td", :text => purchase_history_past_3_months.bought.to_s)
    page.should_not have_selector("td", :text => purchase_expectation_next_month.product.reference)
  end

  scenario "Show purchase expectations as admin when there is no expectations" do
    sign_in_as_admin
    reseller = create_reseller

    click_link "Revendas"
    click_link "Previsão de compra"

    page.should have_selector(".no_item", :text => "A #{reseller.name} ainda não tem previsão de compra para #{I18n.l(Date.today, :format => :month_and_year)}.")
  end
end
