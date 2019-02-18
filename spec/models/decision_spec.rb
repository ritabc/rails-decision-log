require 'rails_helper'

describe Decision do
  it { should belong_to :circle }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :date_decided }

  # it 'creates decision in particular circle as logged in member of that cirlce' do
  #   circle = FactoryBot.create(:circle)
  #
  # end

end
