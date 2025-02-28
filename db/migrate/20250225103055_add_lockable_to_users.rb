class AddLockableToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :failed_attempts, :integer, default: 0, null: false # Tracks failed login attempts
    add_column :users, :unlock_token, :string # Token for unlocking the account
    add_column :users, :locked_at, :datetime # Timestamp for when the account was locked
    add_index :users, :unlock_token, unique: true
  end
end
