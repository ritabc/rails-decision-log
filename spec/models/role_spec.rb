require 'rails_helper'

describe Role do
  it { should belong_to :circle }
  it { should belong_to :user }
  it { should validate_presence_of :role_type }
  it { should validate_presence_of :circle }
  it { should validate_presence_of :user }

  context 'factorybot' do
    it 'create a role from factory' do
      expect(create :role).to be_valid
    end
  end

  it 'validates role type inclusion' do
    role = create :role
    role.role_type = "random"
    expect(role.save).to eq(false)
  end
end
