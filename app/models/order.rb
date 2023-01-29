class Order < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :order_items, -> { order(created_at: :desc) }
  has_many :items, through: :order_items

  validates :group_id, presence: true, unless: :draft?
  validates :accepted_terms_of_service, acceptance: true, unless: :draft?
  validates :has_sch_logo, acceptance: true, unless: :draft?
  validates :has_right_format, acceptance: true, unless: :draft?
  validates :has_date, acceptance: true, unless: :draft?
  validates :order_items, presence: :true, unless: :draft?
  default_scope { where(deleted: :false) }

  enum :state, { draft: 'draft', processing: 'processing', complete: 'complete' }

  def self.paper_sizes_with_translation
    paper_sizes.map { |k, v| [I18n.translate("activerecord.attributes.order.paper_size_enum.#{k}"), v] }
  end

  def self.with_total_price
    joins(:order_items)
      .group('orders.id')
      .select('orders.*',
              'SUM(order_items.price*order_items.quantity) as total_price')
  end

  def total_price
    attribute_total_price =  attributes['total_price']
    return attribute_total_price if attribute_total_price

    order_items.sum do |order_item|
      order_item.price * order_item.quantity
    end
  end
end
