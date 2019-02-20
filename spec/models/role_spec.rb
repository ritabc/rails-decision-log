require 'rails_helper'

describe Role do
  it { should belong_to :circle }
  it { should belong_to :user }
  it { should validate_presence_of :role_type }
  it { should validate_presence_of :circle }
  it { should validate_presence_of :user }
end
