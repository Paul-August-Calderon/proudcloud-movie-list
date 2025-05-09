class Movie < ApplicationRecord
  validates :vote_average, :vote_count, numericality: { greater_than_or_equal_to: 0 }
  validates :vote_average, :vote_count, :title, presence: :true

  scope :with_title_like, ->(query) {
    where("title LIKE ?", "%#{sanitize_sql_like(query)}%")
  }
end
