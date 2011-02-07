require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Set goal" do
  scenario "Scenario name" do
    sign_in_as_admin
    reseller = create_reseller

    click_link "Revendas"
    click_link "Alterar meta"
    fill_in "Meta", :with => 7500
    click_button "Salvar"

    reseller.reload.goal.should be_== 7500
  end
end
