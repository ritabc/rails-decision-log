class Decision < ApplicationRecord
  belongs_to :circle
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :date_decided
  scope(:three_most_recent, -> do
    binding.pry
    where("circle_id = ?", Circle.find(self.circle_id).id)
    .order(date_decided: :desc)
    .limit(3)
  end)
end
