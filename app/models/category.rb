class Category < ApplicationRecord
  has_many :books, dependent: :destroy  # Change to :nullify if you want books to remain

  validates :name, presence: true, uniqueness: true
end
