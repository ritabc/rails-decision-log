class User < ApplicationRecord
  has_many :roles, dependent: :destroy #, inverse_of: :user
  has_many :circles, through: :roles
  validates :email, :presence => true, :uniqueness => { case_sensitive: false }
  has_secure_password
  accepts_nested_attributes_for :roles
  validates_with UserHasOneRolePerCircle

  after_save do |user|
    # If leader, iterate over circles and create new role, role_type: none
    if user.site_admin_type == "leader"
      Circle.all.each do |circle|
        Role.create(role_type: "none", circle: circle, user: user)
      end

    # If super, iterate over circles, create new role, role_type: admin
    elsif user.site_admin_type == "super"
      Circle.all.each do |circle|
        Role.create(role_type: "admin", circle: circle, user: user)
      end
    end
  end

end
