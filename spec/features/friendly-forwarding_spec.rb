require 'rails_helper'

RSpec.feature "Friendly Forwarding", :type => :feature do
  scenario "A public viewer is sent the URL to add a new Decision, logs in, and if friendly forwarded to the same URL" do
    visit '/signout'
    test_user = FactoryBot.create(:user)
    binding.pry
    visit "/decisions/new"
    fill_in('Email', with: test_user.email)
    fill_in('Password', with: test_user.password)
    click_button('Sign in')
    expect(page).to have_text("Log a New Decision")
  end
end
