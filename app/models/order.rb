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

  enum :state, { draft: 'draft', processing: 'processing', complete: 'complete' }

  def self.paper_sizes_with_translation
    paper_sizes.map { |k, v| [I18n.translate("activerecord.attributes.order.paper_size_enum.#{k}"), v] }
  end
end
