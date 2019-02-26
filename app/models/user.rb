class User < ApplicationRecord
  has_many :roles, dependent: :destroy #, inverse_of: :user
  has_many :circles, through: :roles
  validates :email, :presence => true, :uniqueness => { case_sensitive: false }
  has_secure_password
  accepts_nested_attributes_for :roles
  validates_with UserHasOneRolePerCircle
  after_create :assign_roles


private

  def assign_roles
    # If leader, iterate over circles and create new role, role_type: none
    if site_admin_type == "leader"
      Circle.all.each do |circle|
        Role.create(role_type: "none", circle: circle, user: self)
      end

    # If super, iterate over circles, create new role, role_type: admin
    elsif site_admin_type == "super"
      Circle.all.each do |circle|
        Role.create(role_type: "admin", circle: circle, user: self)
      end
    end
  end

end
