class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :price, presence: true
  validates :link, presence: true, url: { public_suffix: true }
  validates :laminated, inclusion: [true, false]
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :comment, presence: true, if: -> { item.id==1 }

  def self.with_total_price
    select('sum(price*quantity) as total_price', '*').group(:id)
  end

  def self.group_prices_for(order_items)
    select('group_id', 'order_id', 'sum(total_price) as group_total_price')
      .from(order_items.with_total_price, 'order_items')
      .joins(:order).group(:group_id, :order_id).includes(order: :group)
      .to_a.map do |row|
      OpenStruct.new(group: row.order.group, price: row.group_total_price)
    end
  end
end
