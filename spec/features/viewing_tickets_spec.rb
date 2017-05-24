require 'rails_helper'

RSpec.feature "Users can view tickets" do
  let(:author) { FactoryGirl.create(:user) }
  before do
    icraft = FactoryGirl.create(:project, name: "iCRaFT", description: "iPhone Repairs")
    piehole = FactoryGirl.create(:project, name: "piehole", description: "Pie Cafe. Delicious pies")
    FactoryGirl.create(:ticket, name: "Slider price update", project: icraft, description: "More prices to update for the slider", author: author)
    FactoryGirl.create(:ticket, name: "Android price update", project: icraft, description: "More prices to update for the android page", author: author)
    FactoryGirl.create(:ticket, name: "Video update", project: piehole, description: "Update the new video to put on the top page", author: author)
    FactoryGirl.create(:ticket, name: "Photo update", project: piehole, description: "Put the new photo to put on the top page", author: author)

    visit "/"
  end

  scenario "for a given project" do
    click_link "iCRaFT"

    expect(page).to have_content "Slider price update"
    expect(page).to have_content "Android price update"
    expect(page).to_not have_content "Video Update"
    expect(page).to_not have_content "Photo update"

    click_link "Slider price update"

    within("#ticket h2") do
      expect(page).to have_content "Slider price update"
    end

    expect(page).to have_content "More prices to update for the slider"
  end
end
