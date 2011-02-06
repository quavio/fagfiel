require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Show Freebie" do
  scenario "Show freebie as admin" do
    sign_in_as_admin
    freebie = create_freebie

    click_link "Brindes"
    click_link freebie.title
    
    page.should have_selector("h1", :content => freebie.title)
    page.should_not have_selector("form")
    page.should have_selector("a", :href => edit_freebie_path(freebie))
  end
end
