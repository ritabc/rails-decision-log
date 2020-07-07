class User < ApplicationRecord
  has_many :roles
  has_many :circles, through: :roles, dependent: :destroy
  validates :email, :presence => true, :uniqueness => { case_sensitive: false }
  has_secure_password
  validates :site_admin_type, inclusion: { in: %w(leader super), message: "%{value} is not a valid site admin type" }
  accepts_nested_attributes_for :roles
  validates_with UserHasOneRolePerCircle
  after_create :assign_roles


  # def send_password_reset
  #   generate_token(:password_reset_token)
  #   self.password_reset_sent_at = Time.zone.now
  #   save!
  #   UserMailer.password_reset(self).deliver
  # end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

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
        Role.create(role_type: "super", circle: circle, user: self)
      end
    end
  end

end
