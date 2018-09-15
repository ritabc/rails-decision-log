class Circle < ApplicationRecord
  has_many :decisions
  validates :name, :presence => true
  validates :description, :presence => true
  validates_associated :decision

end
