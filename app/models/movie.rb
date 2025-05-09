class Movie < ApplicationRecord
  scope :with_title_like, ->(query) {
    where("title LIKE ?", "%#{sanitize_sql_like(query)}%")
  }
end
