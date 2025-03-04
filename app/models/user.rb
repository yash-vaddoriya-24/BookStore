class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :books, through: :orders # User buys books through orders

  rolify strict: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable

  after_create_commit :assign_default_role

  private

  def assign_default_role
    Rails.logger.debug "Assigning default role to user: #{self.id}"
    self.add_role(:customer) unless self.has_role?(:newuser)
  end
end
