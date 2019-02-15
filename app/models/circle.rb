class Circle < ApplicationRecord
  has_many :decisions
  has_many :roles
  has_many :users, through: :roles

  validates :name, :presence => true
  validates :description, :presence => true
end
