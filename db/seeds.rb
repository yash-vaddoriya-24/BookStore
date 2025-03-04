# Clear existing categories to avoid duplicates
Category.destroy_all

# Define category names
categories = [
  "Fiction",
  "Non-Fiction",
  "Science",
  "Technology",
  "Biography",
  "Fantasy",
  "Self-Help",
  "History",
  "Education",
  "Romance"
]

# Create categories
categories.each do |category|
  Category.create!(name: category)
end

puts "✅ Successfully seeded #{Category.count} categories!"
