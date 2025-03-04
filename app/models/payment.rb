class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }
  validates :payment_method, presence: true, inclusion: { in: %w[credit_card debit_card paypal bank_transfer] }
  validates :status, presence: true, inclusion: { in: %w[pending completed failed refunded] }

  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.payment_method ||= "debit_card"
    self.status ||= "pending"
  end
end
