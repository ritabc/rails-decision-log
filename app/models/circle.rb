class Circle < ApplicationRecord
  has_many :decisions
  has_many :roles, dependent: :destroy#, inverse_of: :circle
  has_many :users, through: :roles

  validates :name, :presence => true
  validates :abbreviation, :presence => true
  validates :description, :presence => true

  # accepts_nested_attributes_for :roles

end
