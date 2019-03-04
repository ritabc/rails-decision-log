class Role < ApplicationRecord
  belongs_to :circle#, inverse_of: :roles
  belongs_to :user
  validates :role_type, :presence => true
  validates :circle, :presence => true
  validates :user, :presence => true
  validates :role_type, inclusion: { in: %w(ol er none admin), message: "%{value} is not a valid role type" }
end
