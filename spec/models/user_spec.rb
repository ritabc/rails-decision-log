require 'rails_helper'

describe User do
  it { should have_many :roles }
  it { should have_many :circles }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of :password }

  context 'users' do
    before(:each) do
      Circle.destroy_all
      User.destroy_all
      Role.destroy_all
      @circles = create_list :circle, 4
      @leader = create :leader
    end

    it 'leader is associated with all circles as none role_type' do
      Circle.all.each do |c|
        role = create(:role, role_type: "none", circle: c, user: @leader)
        @leader.roles.push(role)
      end
      expect(@leader.roles.pluck(:role_type)).to eq %w(none none none none)
    end

    it 'creates a valid leader (with a role for each circle) from factory' do
      expect(@leader.roles.count).to eq(Circle.all.count)
    end

    it 'tests authentication' do
      expect(User.find_by(email: @leader.email).try(:authenticate, @leader.password)).to eq(@leader)
    end

    it 'has many roles' do
      expect(@leader.roles.count).to eq 4
    end

    it 'can belong to many circles' do
      expect(@leader.circles.count).to eq 4
    end

    it 'only validates super and leader site admin types' do
      @leader.site_admin_type = "random"
      expect(@leader.save).to eq(false)
    end
  end

  describe "#send_password_reset" do
    before(:each) do
      @user = create :leader
    end
    
    it "generates a unique password_resete_token each time" do
      @user.send_password_reset
      last_token = @user.password_reset_token
      @user.send_password_reset
      @user.password_reset_token.should_not eq(last_token)
    end

    it "saves the time the password reset was sent" do
      @user.send_password_reset
      @user.reload.password_reset_sent_at.should be_present
    end

    it "delivers email to user" do
      @user.send_password_reset
      last_email.to.should include(@user.email)
    end
  end
end
