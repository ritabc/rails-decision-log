require 'rails_helper'

describe Circle do
  it { should have_many :decisions }
  it { should have_many :roles }
  it { should have_many :users }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :abbreviation }

  it 'has associated when specified' do
    circle_with_decisions = create :circle, :with_decisions
    expect(circle_with_decisions.decisions.count).to eq 5
  end

  # it 'will test the three_most_recent scope using FactoryBot' do
  #   test_circle = FactoryBot.create(:circle)
  #   test_decision1 = FactoryBot.create(:decision)
  #   test_decision2 = FactoryBot.create(:decision)
  #   test_decision3 = FactoryBot.create(:decision)
  #   expect(test_decision1.circle_id).to eq(100)
  # end

  # it 'will test the three_most_recent scope without using FactoryBot' do
  #   test_circle = Circle.create(:name => "Land Stewardship", :description => "This is the description for land stewardship")
  #   test_decision1 = Decision.create(:name => "Dig a well", :description => "We decided to dig a well, and cover it with a pump house", :date_decided => Date.new(2016,5,27), :circle_id => test_circle.id)
  #   test_decision2 = Decision.create(:name => "Provide childcare at GC meetings", :description => "We decided to provide childcare at General Circle meetings", :date_decided => Date.new(2016,5,25), :circle_id => test_circle.id)
  #   test_decision3 = Decision.create(:name => "Bring priority proposal to GC", :description => "We decided to bring a proposal on priority for living at HM to the GC", :date_decided => Date.new(2016,5,26), :circle_id => test_circle.id)
  #   expect(Decision.three_most_recent(test_circle)).to(eq([test_decision1, test_decision2, test_decision3]))
  # end
end
