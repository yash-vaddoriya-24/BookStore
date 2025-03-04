class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum :rating, { one: 1, two: 2, three: 3, four: 4, five: 5 }

  validates :rating, presence: true, inclusion: { in: ratings.values }
  validates :comment, presence: true, length: { minimum: 10, maximum: 500 }
end
