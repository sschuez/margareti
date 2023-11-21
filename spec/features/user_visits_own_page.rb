require "rails_helper"

RSpec.feature "User visits own page" do
  scenario "successfully" do
    sign_in

    visit users_user_path

    expect(page).to have_content("Test User")
  end
end