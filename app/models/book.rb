require "csv"

class Book < ApplicationRecord
  acts_as_paranoid

  has_one_attached :image
  belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :isbn, presence: true, uniqueness: true

  # Allow Ransack to search specific attributes
  def self.ransackable_attributes(auth_object = nil)
    [ "author", "created_at", "id", "isbn", "title", "price", "updated_at" ]
  end

  # Allow searching associations
  def self.ransackable_associations(auth_object = nil)
    [ "category", "orders", "reviews" ]
  end

  # Export books to CSV
  def self.to_csv(books = self.all)
    CSV.generate(headers: true) do |csv|
      csv << column_names
      books.each do |book|
        csv << book.attributes.values_at(*column_names)
      end
    end
  end
end
