require 'rails_helper'

describe Decision do
  describe "shoulda validations" do 
    subject {build :decision}
    it { should belong_to :circle }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :date_decided }
    it { should validate_presence_of :circle }
  end

  context 'factorybot' do
    it 'creates a decision belonging to a circle' do
      decision = build :decision
      expect(decision.circle.name).to eq("Land Stewardship")
    end
  end

end
