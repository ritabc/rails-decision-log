class Role < ApplicationRecord
  belongs_to :circle#, inverse_of: :roles
  belongs_to :user#, inverse_of: :roles
  validates :role_type, :presence => true
  validates :circle, :presence => true
  validates :user, :presence => true

  # def display_name_for_collection
  #   "#{role_type}"
  # end
end
