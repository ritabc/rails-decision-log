class Decision < ApplicationRecord
  belongs_to :circle
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :date_decided
  validates_presence_of :circle
  validates_with DateDecidedBeforeToday

  include PgSearch
  pg_search_scope :custom_search, against: [:name, :description],
      using: {tsearch: {dictionary: "english"}}

  scope(:has_and_sort_by_review_by_date, -> () {
    where("review_by_date IS NOT NULL")
    .order(review_by_date: :desc)
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
