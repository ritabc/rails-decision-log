require 'rails_helper'

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    permission.allow?(*args)
  end
end

describe Permission do

  context 'User as guest' do
    subject { Permission.new(nil) }
    it { should allow(:decisions, :all) }
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

    context 'without circles associated with them' do

      let(:circle) { create :circle }
      let(:circle_with_decisions ) { create :circle_with_decisions }

      subject { Permission.new(create :leader, email: "rita#{rand(10)}@email.com") }

      it { should allow(:decisions, :all) }

      it { should allow(:circles, :index) }
      it { should allow(:circles, :new) }
      it { should allow(:circles, :create) }
      it { should allow(:circles, :edit) }
      it { should allow(:circles, :update) }
      it { should allow(:circles, :destroy, circle) }
      it { should_not allow(:circles, :destroy, circle_with_decisions) }

      it 'should check sessions' do
        should allow(:sessions, :new)
        should allow(:sessions, :create)
        should allow(:sessions, :destroy)
      end
    end

    context 'users controller' do
      let(:themself) { create :leader, email: "rita#{rand(10)}@email.com" }
      let(:another) { create :leader, email: "rbc#{rand(10)}@email.com" }
      subject { Permission.new(themself)}
      it { should allow(:users, :edit, themself) }
      it { should allow(:users, :update, themself) }
      it { should allow(:users, :destroy, themself) }
      it { should allow(:users, :show, themself) }
      it { should_not allow(:users, :show, another) }
      it { should_not allow(:users, :edit, another) }
      it { should_not allow(:users, :update, another) }
      it { should_not allow(:users, :destroy, another) }

    end

    context "either associated or not with circle of decision attempting to add" do

      before(:all) do
        Circle.destroy_all
        Role.destroy_all
        @non_associated_circle = create(:circle)
        @non_associated_decision = create(:decision, circle: @non_associated_circle)
        @associated_circle = create :circle
        @associated_decision = create(:decision, circle: @associated_circle)
      end

      # Gets hit during every test
      subject do
        leader = User.create(email: "rita1@email.com", password: "pass123", password_confirmation: "pass123", site_admin_type: "leader")
        # binding.pry # Should have 2 roles (b.c there's 2 circles), both are None type
        # Give access to leader for associated_circle
        associated_role = Role.find_by(user: leader, circle: @associated_circle)
        associated_role.role_type = "circle_admin"
        associated_role.save
        Permission.new(leader)
      end
      #
      it { should allow(:decisions, :all) }
      it { should allow(:decisions, :new, @associated_decision) }
      it { should allow(:decisions, :create, @associated_decision) }
      it { should allow(:decisions, :edit, @associated_decision) }
      it { should allow(:decisions, :update, @associated_decision) }
      it { should allow(:decisions, :destroy, @associated_decision) }
      it { should allow(:decisions, :new, @non_associated_decision) }
      # it { should_not allow(:decisions, :create, @non_associated_decision) }
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

  context 'User as super' do

    context 'users controller' do

      let(:themself) { create :super, email: "rita#{rand(10)}@email.com" }
      let(:another) { create :super, email: "rbc#{rand(10)}@email.com" }

      subject { Permission.new(themself)}

      it { should allow(:users, :edit, themself) }
      it { should allow(:users, :update, themself) }
      it { should allow(:users, :destroy, themself) }
      it { should allow(:users, :show, themself) }
      it { should allow(:users, :edit, another) }
      it { should allow(:users, :update, another) }
      it { should allow(:users, :destroy, another) }
      it { should_not allow(:users, :show, another) }

    end
  end
end
