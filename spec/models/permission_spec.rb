require 'rails_helper'

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    permission.allow?(*args)
  end
end

describe Permission do

  context 'User as guest' do
    subject { Permission.new(nil) }
    it { should allow(:decisions, :index) }
    it { should_not allow(:decisions, :new) }
    it { should_not allow(:decisions, :create) }
    it { should_not allow(:decisions, :edit) }
    it { should_not allow(:decisions, :update) }
    it { should_not allow(:decisions, :destroy) }

    it { should allow(:circles, :index) }

    it { should_not allow(:circles, :new) }
    it { should_not allow(:circles, :create) }
    it { should_not allow(:circles, :edit) }
    it { should_not allow(:circles, :update) }
    it { should_not allow(:circles, :destroy) }

    it { should_not allow(:users, :index) }
    it { should_not allow(:users, :new) }
    it { should_not allow(:users, :create) }
    it { should_not allow(:users, :edit) }
    it { should_not allow(:users, :update) }
    it { should_not allow(:users, :destroy) }

    it 'should check sessions' do
      should allow(:sessions, :new)
      should allow(:sessions, :create)
      should allow(:sessions, :destroy)
    end
  end

  context 'User logged in as leader' do

    context 'without circles associated to them' do

      subject { Permission.new(create(:leader)) }

      it { should allow(:decisions, :index) }

      it { should allow(:circles, :index) }
      it { should allow(:circles, :new) }
      it { should allow(:circles, :create) }
      # it { should allow("circles", "edit") } # For now, ulitmately editing at this level will be restricted to name and description (not associating users)
      # it { should allow("circles", "update") }
      # it { should allow("circles", "destroy") }
      #
      # it { should allow("users", "new") } # These 2: Can only add the type of themself of lower (leader < super)
      # it { should allow("users", "create") }
      # it { should_not allow("users", "edit") } # These 3: Ideally, allow iff editing self
      # it { should_not allow("users", "update") }
      # it { should_not allow("users", "destroy") }

      it 'should check sessions' do
        should allow(:sessions, :new)
        should allow(:sessions, :create)
        should allow(:sessions, :destroy)
      end
    end

    context "either associated or not with circle of decision attempting to add" do

      # create a non-associated decision
      # let(:non_associated_decision) { create(:decision) }
      #
      # # create an associated decisions
      # let(:associated_decision) { create(:decision) }
      #
      # # Associate a circle with leader through role
      # let(:leader_of_associated_circle) do
      #   # create leader with many_circles
      #   leader = create(:leader_with_circles)
      #   leaders_circle = leader.circles.first
      #   leaders_circle.decisions.push(associated_decision)
      #   role = create(:role, circle: leaders_circle, user: leader)
      #   leader
      # end

      # subject { Permission.new(leader_of_associated_circle) }

      before(:all) do
        @non_associated_decision = create(:decision)
        @associated_decision = create(:decision)
      end

      # needs to return a permission
      subject do
        circle = create :circle
        circle.decisions.push(@associated_decision) # @assoc_dec now belongs to circle
        leader = create :leader
        create(:role, circle: circle, user: leader) # circle and leader now assoc.
        Permission.new(leader)
      end

      it { should allow(:decisions, :index) }
      it { should allow(:decisions, :new, @associated_decision) }
      it { should allow(:decisions, :create, @associated_decision) }
      it { should allow(:decisions, :edit, @associated_decision) }
      it { should allow(:decisions, :update, @associated_decision) }
      it { should allow(:decisions, :destroy, @associated_decision) }
      it { should allow(:decisions, :new, @non_associated_decision) }
      it { should allow(:decisions, :create, @non_associated_decision) }
      it { should_not allow(:decisions, :edit, @non_associated_decision) }
      it { should_not allow(:decisions, :update, @non_associated_decision) }
      it { should_not allow(:decisions, :destroy, @non_associated_decision) }

      it 'should check sessions' do
        should allow(:sessions, :new)
        should allow(:sessions, :create)
        should allow(:sessions, :destroy)
      end
    end
  end

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

    it { should allow(:any, :all) }
  end
end
