class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy

  validates :status, presence: true, inclusion: { in: %w[pending confirmed canceled delivered] }

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= "pending"
  end
end
