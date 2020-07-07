require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do

  Decision.destroy_all
  Circle.destroy_all

  it 'emails user when requesting password reset' do
    user = create :leader
    visit signin_path
    click_link "Forgot"
    fill_in "Email", :with => user.email
    click_button "Reset Password"
    current_path.should eq(root_path)
    page.should have_content("Email sent")
    last_email.to.should include(user.email)
  end
end
