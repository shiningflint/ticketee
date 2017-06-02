require "rails_helper"

RSpec.feature "Project managers can edit projects" do
  let(:user) { FactoryGirl.create(:user) }
  before do
    login_as user
    project = FactoryGirl.create(:project, name: "Sublime Text 3")
    assign_role!(user, :manager, project)

    visit "/"
    click_link "Sublime Text 3"
    click_link "Edit Project"

    expect(page.current_url).to eq edit_project_url(project)
  end

  scenario "Edit the project with valid attributes" do
    fill_in "Name", with: "Sublime Text 4"
    fill_in "Description", with: "A text editor for everyone version 4"
    click_button "Update Project"

    expect(page).to have_content "Project has been updated"
    expect(page).to have_content "Sublime Text 4"
    expect(page).to have_content "A text editor for everyone version 4"
  end

  scenario "Edit the project with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content "Project has not been updated."
    expect(page).to have_content "Name can't be blank"
  end
end
