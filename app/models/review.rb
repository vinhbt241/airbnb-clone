class Review < ApplicationRecord
  validates :body, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  belongs_to :reviewable, polymorphic: true
end
