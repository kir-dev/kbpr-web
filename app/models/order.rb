class Order < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :paper_size, presence: true
  validates :accepted_terms_of_service, acceptance: true
  validates :has_sch_logo, acceptance: true
  validates :has_right_format, acceptance: true
  validates :has_date, acceptance: true
  validates :link, presence: true
  validates :print_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  enum :paper_size, { a2: 'a2', a3: 'a3', a4: 'a4', a5: 'a5', a6: 'a6', other: 'other' }

  def self.paper_sizes_with_translation
    paper_sizes.map { |k, v| [I18n.translate("activerecord.attributes.order.paper_size_enum.#{k}"), v] }
  end
end
