# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Show FAQ" do
  scenario "Scenario name" do
    sign_in_as_admin
    click_link "FAQ"
    page.should have_selector("h1", :text => "Perguntas Freqüentes (FAQ)")
  end
end
