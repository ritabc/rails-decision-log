require 'rails_helper'

describe Role do
  it { should belong_to :circle }
  it { should belong_to :user }
end
