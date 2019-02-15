class Decision < ApplicationRecord
  belongs_to :circle
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :date_decided

  include PgSearch
  pg_search_scope :custom_search, against: [:name, :description],
      using: {tsearch: {dictionary: "english"}}

  scope(:three_most_recent, -> (circle) {
    where("circle_id = ?", circle.id)
    .order(date_decided: :desc)
    .limit(3)
  })

  def self.name_description_search(search)
    if search.present?
      custom_search(search)
    else
      Decision.all
    end
  end

  def has_doc?(doc_number)
    if doc_number == 'one'
      !(supp_doc_one_type.nil? || supp_doc_one_type.empty?)
    elsif doc_number == 'two'
      !(supp_doc_two_type.nil? || supp_doc_two_type.empty?)
    end
  end
end
