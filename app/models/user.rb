class User < ApplicationRecord
  has_many :roles
  has_many :circles, through: :roles
  validates :email, :presence => true, :uniqueness => { case_sensitive: false }
  has_secure_password

end
