# coding:utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Make contact" do
  scenario "" do
    sign_in_as_admin

    click_link I18n.t("links.menu.contact")
    fill_in I18n.t("contact_form.message"), :with => "Hello world!"
    click_button I18n.t("contact_form.send")

    ActionMailer::Base.deliveries.first.subject.should be_== "Contato através do Portal Fag Fiel"
    page.should have_selector("p.notice", :content => I18n.t("notices.contact.sent"))
  end
end
