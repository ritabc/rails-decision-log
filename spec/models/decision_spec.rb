require 'rails_helper'

describe Decision do
  it { should belong_to :circle }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :date_decided }
  it { should validate_presence_of :circle }


  # Needs editing or removing in favor of permissions_spec
  context 'being interacted with by user', type: :request do
    it 'who can edit own circles decisions' do
      # create leader with many_circles and a decision
      associated_decision = create :decision
      leader = create(:leader, :with_many_circles)
      leaders_circle = leader.circles.first
      leaders_circle.decisions.push(associated_decision)
      role = create(:role, circle: leaders_circle, user: leader)
      User.find(leader.id).try(:authenticate, leader.password)
      visit signin_path
      fill_in 'email', with: "#{leader.email}"
      fill_in 'password', with: "#{leader.password}"
      find('input[name="commit"]').click
      visit edit_decision_path(associated_decision)
      page.should have_content("Edit the Decision: #{associated_decision.name}")
    end
  end

end
