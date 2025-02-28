class Message < ApplicationRecord
  belongs_to :entry, inverse_of: :entryable
end
