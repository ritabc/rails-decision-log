class Decision < ApplicationRecord
  belongs_to :circle
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :date_decided

  scope(:three_most_recent, -> (circle) {
    where("circle_id = ?", circle.id)
    .order(date_decided: :desc)
    .limit(3)
  })

  def self.search(search)
    if search
      decisions = Decision.where("lower(name) LIKE ?", "%#{search.downcase}%")
    else
      decisions = Decision.all
    end
  end
end
