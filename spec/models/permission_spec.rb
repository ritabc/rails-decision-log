require 'rails_helper'

# Allow Checks for authorization of whether user is allowed to do the thing as leader/super/viewer, and for whether they're associated with the circle
RSpec::Matchers.define :allow do |controller, action, condition = true|
  match do |permission|
    condition && permission.allow?(controller, action)
  end
end

describe Permission do

  # context 'User as viewer' do
  #   subject { Permission.new(user: nil, circle: build(:circle), decision: build(:decision)) }
  #   it { should allow("decisions", "index") }
  #   it { should_not allow("decisions", "new") }
  #   it { should_not allow("decisions", "create") }
  #   it { should_not allow("decisions", "edit") }
  #   it { should_not allow("decisions", "update") }
  #   it { should_not allow("decisions", "destroy") }
  #
  #   it { should allow("sessions", "new") }
  #   it { should allow("sessions", "create") }
  #   it { should allow("sessions", "destroy") }
  #
  #   it { should allow("circles", "index") }
  #   it { should_not allow("circles", "new") }
  #   it { should_not allow("circles", "create") }
  #   it { should_not allow("circles", "edit") }
  #   it { should_not allow("circles", "update") }
  #   it { should_not allow("circles", "destroy") }
  #
  #   it { should_not allow("users", "new") }
  #   it { should_not allow("users", "create") }
  #   it { should_not allow("users", "edit") }
  #   it { should_not allow("users", "update") }
  #   it { should_not allow("users", "destroy") }
  # end

  context 'User as leader' do
    context 'of Circle with Decisions' do

      let!(:one_decision) { create :decision, name: "One" }
      let!(:circle_with_decisions) do
        circle = create(:circle, :with_decisions)
        circle.decisions.push(one_decision)
        circle
      end
      let!(:leader_with_many_circles) do
        leader = create(:leader, :with_many_circles)
        leader.circles.push(circle_with_decisions)
        leader
      end
      subject (:a) do
        Permission.new(user: leader_with_many_circles, circle: circle_with_decisions, decision: one_decision)
      end

      it { should allow("decisions", "index") }
      it { should allow("decisions", "new", a.decision_belongs_to_circle_user_involved_in?) }
    end
    # context 'of Circle not having Decision in Question' do
    #   leaderless_circle = create :circle, name: "Leaderless Circle"
    # end
  end
end
