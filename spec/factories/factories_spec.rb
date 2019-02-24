require 'rails_helper'

# Tests that factories are building valid models
context 'factorybot' do

  it 'creates a decision belonging to a circle' do
    decision = build :decision
    expect(decision.circle.name).to eq("Land Stewardship")
  end

  it 'creates a valid leader (circle-less) from factory' do
    leader = create :leader
    expect(leader).to be_valid
    expect(leader.roles).to eq []
  end

  it 'create a role from factory' do
    expect(create :role).to be_valid
  end
end
