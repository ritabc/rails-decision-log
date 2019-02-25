class User < ApplicationRecord
  has_many :roles #, inverse_of: :user
  has_many :circles, through: :roles
  validates :email, :presence => true, :uniqueness => { case_sensitive: false }
  has_secure_password
  accepts_nested_attributes_for :roles


end
