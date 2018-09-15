require 'rails_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_confirmation_of :password }
  # 
  # it 'will test user authentication' do
  #   test_user = FactoryBot.create(:user)
  #   expect(User.authenticate(test_user.email, test_user.password)).to eq(test_user)
  # end
end
