class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :price, presence: true
  validates :link, presence: true
  validates :laminated, inclusion: [true, false]
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
