require 'rails_helper'

RSpec.feature "Friendly Forwarding", :type => :feature do
  scenario "A public viewer is sent the URL to add a new Decision, logs in, and if friendly forwarded to the same URL" do
    test_user = FactoryBot.create(:user)
    binding.pry
    visit "/decisions/new"
    fill_in('Email', with: "rita@test.com")
    fill_in('Password', with: "password")
    expect(page).to have_text("Log a New Decision")
  end
end
