class User < ApplicationRecord
  has_many :roles
  has_many :circles, through: :roles
  validates :email, :presence => true, :uniqueness => { case_sensitive: false }
  has_secure_password

  def leader?
    user.site_admin_type == 'leader'
  end

  def super?
    user.site_admin_type == 'super'
  end

end
