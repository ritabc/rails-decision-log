require 'rails_helper'

RSpec::Matchers.define :allow do |controller, action|
  match do |permission|
    permission.allow?(controller, action)
  end
end

describe Permission do

  context 'User as viewer' do
    subject { Permission.new(user: nil, circle: build(:circle), decision: build(:decision)) }
    it { should allow("decisions", "index") }
    it { should_not allow("decisions", "new") }
    it { should_not allow("decisions", "create") }
    it { should_not allow("decisions", "edit") }
    it { should_not allow("decisions", "update") }
    it { should_not allow("decisions", "destroy") }

    it { should allow("sessions", "new") }
    it { should allow("sessions", "create") }
    it { should allow("sessions", "destroy") }

    # it { should allow("circles", "index") }
    # it { should_not allow("circles", "new") }
    # it { should_not allow("circles", "create") }
    # it { should_not allow("circles", "edit") }
    # it { should_not allow("circles", "update") }
    # it { should_not allow("circles", "destroy") }
    #
    # it { should_not allow("users", "new") }
    # it { should_not allow("users", "create") }
    # it { should_not allow("users", "edit") }
    # it { should_not allow("users", "update") }
    # it { should_not allow("users", "destroy") }
  end

  context 'User as leader' do
    context 'of Circle with Specific Decision' do

      let(:specific_decision) { create :decision }
      let(:circle_with_specific_decision) do
        circle = create(:circle, :with_decisions)
        circle.decisions.push(specific_decision)
        circle
      end
      let(:leader_with_specific_circle) do
        leader = create(:leader, :with_many_circles)
        leader.circles.push(circle_with_specific_decision)
        leader
      end

      subject { Permission.new(user: leader_with_specific_circle, circle: circle_with_specific_decision, decision: specific_decision) }

      it { should allow("decisions", "index") }
      it { should allow("decisions", "new") }
      it { should allow("decisions", "create") }
      it { should allow("decisions", "edit") }
      it { should allow("decisions", "update") }
      it { should allow("decisions", "destroy") }

      it { should allow("sessions", "new") }
      it { should allow("sessions", "create") }
      it { should allow("sessions", "destroy") }
    end

    context 'not being involved in Circle of Decision in Question' do
      let(:specific_decision) { create :decision }
      let(:circle_with_specific_decision) do
        circle = create(:circle, :with_decisions)
        circle.decisions.push(specific_decision)
        circle
      end
      let(:non_leader_of_specific_circle) { create(:leader, :with_many_circles) }

      subject { Permission.new(user: non_leader_of_specific_circle, circle: circle_with_specific_decision, decision: specific_decision) }

      it { should allow("decisions", "index") }
      it { should allow("decisions", "new") }
      it { should_not allow("decisions", "create") }
      it { should_not allow("decisions", "edit") }
      it { should_not allow("decisions", "update") }
      it { should_not allow("decisions", "destroy") }

      it { should allow("sessions", "new") }
      it { should allow("sessions", "create") }
      it { should allow("sessions", "destroy") }
    end

    context 'of Circle not having Decision in Question' do
      let(:specific_decision) { create :decision }
      let(:circle_with_decisions_but_not_specific_decision) { create :circle, :with_decisions }
      let(:leader_of_specific_circle) do
        leader = create(:leader, :with_many_circles)
        leader.circles.push(circle_with_decisions_but_not_specific_decision)
        leader
      end

      subject { Permission.new(user: leader_of_specific_circle, circle: circle_with_decisions_but_not_specific_decision, decision: specific_decision) }

      it { should allow("decisions", "index") }
      it { should allow("decisions", "new") }
      it { should_not allow("decisions", "create") }
      it { should_not allow("decisions", "edit") }
      it { should_not allow("decisions", "update") }
      it { should_not allow("decisions", "destroy") }

      it { should allow("sessions", "new") }
      it { should allow("sessions", "create") }
      it { should allow("sessions", "destroy") }

    end
  end
end
