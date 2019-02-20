class Role < ApplicationRecord
  belongs_to :circle
  belongs_to :user
  validates :role_type, :presence => true
  validates :circle, :presence => true
  validates :user, :presence => true
end
