# Clear existing records to prevent duplicates
Book.destroy_all

# Create 30 sample books
books = [
  { name: "1984", author: "George Orwell", isbn: "9780451524935", price: 350 },
  { name: "To Kill a Mockingbird", author: "Harper Lee", isbn: "9780061120084", price: 399 },
  { name: "The Great Gatsby", author: "F. Scott Fitzgerald", isbn: "9780743273565", price: 299 },
  { name: "Moby Dick", author: "Herman Melville", isbn: "9781503280786", price: 450 },
  { name: "Pride and Prejudice", author: "Jane Austen", isbn: "9781503290563", price: 299 },
  { name: "The Catcher in the Rye", author: "J.D. Salinger", isbn: "9780316769488", price: 320 },
  { name: "The Hobbit", author: "J.R.R. Tolkien", isbn: "9780547928227", price: 499 },
  { name: "War and Peace", author: "Leo Tolstoy", isbn: "9781420954309", price: 650 },
  { name: "The Alchemist", author: "Paulo Coelho", isbn: "9780062315007", price: 280 },
  { name: "Brave New World", author: "Aldous Huxley", isbn: "9780060850524", price: 330 },
  { name: "The Book Thief", author: "Markus Zusak", isbn: "9780375842207", price: 360 },
  { name: "Crime and Punishment", author: "Fyodor Dostoevsky", isbn: "9780486415871", price: 400 },
  { name: "Wuthering Heights", author: "Emily Brontë", isbn: "9781853260018", price: 310 },
  { name: "Anna Karenina", author: "Leo Tolstoy", isbn: "9780143035008", price: 490 },
  { name: "The Grapes of Wrath", author: "John Steinbeck", isbn: "9780143039433", price: 430 },
  { name: "The Picture of Dorian Gray", author: "Oscar Wilde", isbn: "9780141439570", price: 270 },
  { name: "Dracula", author: "Bram Stoker", isbn: "9780486411095", price: 350 },
  { name: "The Brothers Karamazov", author: "Fyodor Dostoevsky", isbn: "9780374528379", price: 540 },
  { name: "One Hundred Years of Solitude", author: "Gabriel Garcia Marquez", isbn: "9780060883287", price: 420 },
  { name: "Les Misérables", author: "Victor Hugo", isbn: "9780451419439", price: 480 },
  { name: "The Count of Monte Cristo", author: "Alexandre Dumas", isbn: "9780140449266", price: 600 },
  { name: "The Road", author: "Cormac McCarthy", isbn: "9780307387899", price: 320 },
  { name: "Fahrenheit 451", author: "Ray Bradbury", isbn: "9781451673319", price: 290 },
  { name: "The Sun Also Rises", author: "Ernest Hemingway", isbn: "9780743297332", price: 360 },
  { name: "Slaughterhouse-Five", author: "Kurt Vonnegut", isbn: "9780440180296", price: 310 },
  { name: "The Stranger", author: "Albert Camus", isbn: "9780679720201", price: 280 },
  { name: "Frankenstein", author: "Mary Shelley", isbn: "9780486282114", price: 260 },
  { name: "Beloved", author: "Toni Morrison", isbn: "9781400033416", price: 330 },
  { name: "Mansfield Park", author: "Jane Austen", isbn: "9780141439808", price: 310 }
]

books.each do |book|
  Book.create!(book)
end

puts "✅ Seeded #{Book.count} books successfully!"
