class Group < ApplicationRecord
  has_many :orders

  def self.price_for(order_items)
    all
      .select('groups.*', 'sum(price*quantity) as price')
      .joins(:orders)
      .joins("join (#{order_items.to_sql}) order_items on order_items.order_id = orders.id")
      .group('groups.id')
  end
end
