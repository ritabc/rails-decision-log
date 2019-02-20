require 'rails_helper'

describe User do
  it { should have_many :roles }
  it { should have_many :circles }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of :password }

  it 'tests authentication' do
    test_user = create(:leader)
    expect(User.find_by(email: test_user.email).try(:authenticate, test_user.password)).to eq(test_user)
  end

  let(:leader_with_many_circles) { create :leader, :with_many_circles }

  it 'creates a valid leader from factory' do
    expect(build :leader).to be_valid
  end
  it 'creates a valid leader with with_many_circles trait' do
    expect(leader_with_many_circles).to be_valid
  end
  it 'can belong to many circles' do
    expect(leader_with_many_circles.circles.count).to eq 5
  end
  it 'creates a leader not belonging to a certain circle' do
    leaderless_circle = create :circle, name: "Leaderless Circle"
    expect(leader_with_many_circles.circles.include?(leaderless_circle)).to eq false
  end

  context 'logged in as Leader' do
    it 'can add a decision to a circle they are in' do
      led_circle = leader_with_many_circles.circles.first

    end
    it 'cannot add a decision to a circle they are not in' do

    end
  end

  it 'creates a leader with valid roles from factory' do
    expect(leader_with_many_circles.roles.count).to eq 5
  end
end
