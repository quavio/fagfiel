# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Add Freebie", %q{
  In order to keep freebies base up to date
  As an admin
  I want to add new freebies
} do

  scenario "when freebie is valid" do
    sign_in_as_admin
    
    click_link "Brindes"
    click_link "Novo brinde"
    fill_in "Nome", :with => "My freebie"
    fill_in "Descrição", :with => "My freebie description"
    fill_in "Preço", :with => "5"
    attach_file "Foto", "spec/fixtures/freebie.jpeg"
    click_button "Criar Brinde"

    Freebie.last.title.should be_== "My freebie"
    page.should have_selector("h1", :text => "My freebie")
  end

  scenario "when it's a course" do
    sign_in_as_admin
    
    click_link "Brindes"
    click_link "Novo brinde"
    fill_in "Nome", :with => "My course"
    fill_in "Descrição", :with => "My course description"
    fill_in "Preço", :with => "10"
    attach_file "Foto", "spec/fixtures/freebie.jpeg"
    check "Curso"
    fill_in "Limite de participantes", :with => 60
    click_button "Criar Brinde"

    Freebie.last.title.should be_== "My course"
    page.should have_selector("h1", :text => "My course (curso)")
    page.should have_selector("p", :text => "Limite de 60 participantes.")
  end
end
