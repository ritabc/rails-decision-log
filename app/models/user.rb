class User < ApplicationRecord
  validates :email, :presence => true, :uniqueness => { case_sensitive: false }
  before_save { self.email = email.downcase }
  has_secure_password

end
