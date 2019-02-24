require 'rails_helper'

describe User do
  it { should have_many :roles }
  it { should have_many :circles }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of :password }

  it 'creates a valid leader from factory' do
    expect(build :leader_with_circles).to be_valid
  end


  let(:test_leader) { create :leader_with_circles }

  it 'tests authentication' do
    expect(User.find_by(email: test_leader.email).try(:authenticate, test_leader.password)).to eq(test_leader)
  end

  it 'creates a valid leader with with_many_circles trait' do
    expect(test_leader).to be_valid
  end

  it 'can belong to many circles' do
    expect(test_leader.circles.count).to eq 5
  end

  it 'creates a leader not belonging to a certain circle' do
    leaderless_circle = create :circle, name: "Leaderless Circle"
    expect(test_leader.circles.include?(leaderless_circle)).to eq false
  end

  it 'creates a leader with valid roles from factory' do
    expect(test_leader.roles.count).to eq 5
  end
end
