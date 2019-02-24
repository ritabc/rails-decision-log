require 'rails_helper'

describe User do
  it { should have_many :roles }
  it { should have_many :circles }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of :password }

  let(:leader_with_circles) do
    circles = create_list :circle, 4
    leader = create :leader
    circles.each { |circle| create :role, user: leader, circle: circle }
    leader
  end

  it 'tests authentication' do
    expect(User.find_by(email: leader_with_circles.email).try(:authenticate, leader_with_circles.password)).to eq(leader_with_circles)
  end

  it 'has many roles' do
    expect(leader_with_circles.roles.count).to eq 4
  end

  it 'can belong to many circles' do
    expect(leader_with_circles.circles.count).to eq 4
  end

  it 'creates a leader not belonging to a certain circle' do
    leaderless_circle = create :circle, name: "Leaderless Circle"
    expect(leader_with_circles.circles.include?(leaderless_circle)).to eq false
  end

end
