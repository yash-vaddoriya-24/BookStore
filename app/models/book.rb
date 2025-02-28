require 'csv'
class Book < ApplicationRecord
  acts_as_paranoid

  # Allow Ransack to search only these attributes
  def self.ransackable_attributes(auth_object = nil)
    [ "author", "created_at", "id", "isbn", "name", "price", "updated_at" ]
  end

  # If using associations, also allow searching them (optional)
  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.to_csv(books)
    puts books.inspect
    CSV.generate(headers: true) do |csv|
      csv << column_names
      books.each do |book|
        csv << book.attributes.values_at(*column_names)
      end
    end
  end

end
