require 'rails_helper'

RSpec.feature "Users can delete exisiting tickets" do
  let(:author) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: author) }

  before do
    assign_role!(author, :viewer, project)
    login_as author
    visit project_ticket_path(project, ticket)
  end

  scenario "Deleting ticket successfully" do
    click_link "Delete Ticket"

    expect(page).to have_content "Ticket has been deleted."
    expect(page.current_url).to eq project_url(project)
  end
end
