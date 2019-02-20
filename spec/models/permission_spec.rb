require 'rails_helper'

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    permission.allow?(*args)
  end
end

describe Permission do

  context 'User as guest' do
    subject { Permission.new(nil) }
    it { should allow("decisions", "index") }
    it { should_not allow("decisions", "new") }
    it { should_not allow("decisions", "create") }
    it { should_not allow("decisions", "edit") }
    it { should_not allow("decisions", "update") }
    it { should_not allow("decisions", "destroy") }

    it { should allow("sessions", "new") }
    it { should allow("sessions", "create") }
    it { should allow("sessions", "destroy") }

    it { should allow("circles", "index") }

    it { should_not allow("circles", "new") }
    it { should_not allow("circles", "create") }
    it { should_not allow("circles", "edit") }
    it { should_not allow("circles", "update") }
    it { should_not allow("circles", "destroy") }

    it { should_not allow("users", "view") }
    it { should_not allow("users", "new") }
    it { should_not allow("users", "create") }
    it { should_not allow("users", "edit") }
    it { should_not allow("users", "update") }
    it { should_not allow("users", "destroy") }
  end

  context 'User is logged in' do

    subject { Permission.new(create(:leader)) }

    it { should allow("decisions", "index") }

    it { should allow("sessions", "new") }
    it { should allow("sessions", "create") }
    it { should allow("sessions", "destroy") }
    #
    it { should allow("circles", "index") }
    it { should allow("circles", "new") }
    it { should allow("circles", "create") }
    # it { should allow("circles", "edit") } # For now, ulitmately editing at this level will be restricted to name and description (not associating users)
    # it { should allow("circles", "update") }
    # it { should allow("circles", "destroy") }
    #
    # it { should allow("users", "new") } # These 2: Can only add the type of themself of lower (leader < super)
    # it { should allow("users", "create") }
    # it { should_not allow("users", "edit") } # These 3: Ideally, allow iff editing self
    # it { should_not allow("users", "update") }
    # it { should_not allow("users", "destroy") }
  end

  # context 'leader of Circle with Specific Decision' do
  #
  #   let(:specific_decision) { create :decision }
  #   let(:circle_with_specific_decision) do
  #     circle = create(:circle, :with_decisions)
  #     circle.decisions.push(specific_decision)
  #     circle
  #   end
  #   let(:leader_with_specific_circle) do
  #     leader = create(:leader, :with_many_circles)
  #     leader.circles.push(circle_with_specific_decision)
  #     leader
  #   end
  #
  #   # subject { Permission.new(user: leader_with_specific_circle, circle: circle_with_specific_decision, decision: specific_decision) }
  #
  #   it { should allow("decisions", "index") }
  #   it { should allow("decisions", "new") }
  #   it { should allow("decisions", "create") }
  #   it { should allow("decisions", "edit") }
  #   it { should allow("decisions", "update") }
  #   it { should allow("decisions", "destroy") }
  #
  # end

  # context 'leader not involved in Circle of Decision in Question' do
  #   let(:specific_decision) { create :decision }
  #   let(:circle_with_specific_decision) do
  #     circle = create(:circle, :with_decisions)
  #     circle.decisions.push(specific_decision)
  #     circle
  #   end
  #   let(:non_leader_of_specific_circle) { create(:leader, :with_many_circles) }
  #
  #   subject { Permission.new(user: non_leader_of_specific_circle, circle: circle_with_specific_decision, decision: specific_decision) }
  #
  #   it { should allow("decisions", "index") }
  #   it { should allow("decisions", "new") }
  #   it { should_not allow("decisions", "create") }
  #   it { should_not allow("decisions", "edit") }
  #   it { should_not allow("decisions", "update") }
  #   it { should_not allow("decisions", "destroy") }
  #
  #   it { should allow("sessions", "new") }
  #   it { should allow("sessions", "create") }
  #   it { should allow("sessions", "destroy") }
  # end

  # context 'leader of Circle not having Decision in Question' do
  #   let(:specific_decision) { create :decision }
  #   let(:circle_with_decisions_but_not_specific_decision) { create :circle, :with_decisions }
  #   let(:leader_of_specific_circle) do
  #     leader = create(:leader, :with_many_circles)
  #     leader.circles.push(circle_with_decisions_but_not_specific_decision)
  #     leader
  #   end
  #
  #   subject { Permission.new(user: leader_of_specific_circle, circle: circle_with_decisions_but_not_specific_decision, decision: specific_decision) }
  #
  #   it { should allow("decisions", "index") }
  #   it { should allow("decisions", "new") }
  #   it { should_not allow("decisions", "create") }
  #   it { should_not allow("decisions", "edit") }
  #   it { should_not allow("decisions", "update") }
  #   it { should_not allow("decisions", "destroy") }
  #
  #   it { should allow("sessions", "new") }
  #   it { should allow("sessions", "create") }
  #   it { should allow("sessions", "destroy") }
  #
  # end


  context 'User as super' do

    subject { Permission.new(create(:super)) }

    it { should allow("any", "all") }
  end
end
