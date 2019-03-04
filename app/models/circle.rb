class Circle < ApplicationRecord
  has_many :decisions
  has_many :roles
  has_many :users, through: :roles, dependent: :destroy

  validates :name, :presence => true
  validates :abbreviation, :presence => true
  validates :description, :presence => true

  after_create :assign_roles

private

  def assign_roles
    User.all.each do |user|
      if user.site_admin_type == "leader"
        Role.create(role_type: "none", circle: self, user: user)
      elsif user.site_admin_type == "super"
        Role.create(role_type: "super", circle: self, user: user)
      end
    end
  end

end
