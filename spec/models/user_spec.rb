require 'rails_helper'

describe User do
  it { should have_many :roles }
  it { should have_many :circles }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of :password }
  #
  # it 'will test user authentication' do
  #   test_user = FactoryBot.create(:user)
  #   expect(User.authenticate(test_user.email, test_user.password)).to eq(test_user)
  # end

  let(:leader_with_many_circles) { create :leader, :with_many_circles }

  it 'creates a valid leader from factory' do
    build(:leader).should be_valid
  end
  it 'creates a valid leader with many circles from factory' do
    leader_with_many_circles.should be_valid
  end
  it 'can belong to many circles' do
    expect(leader_with_many_circles.circles.count).to eq 6
  end
end
