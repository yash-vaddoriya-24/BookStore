class Comment < ApplicationRecord
  belongs_to :entry, inverse_of: :entryable
end
