class Order < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :paper_size, presence: true
  validates :has_sch_logo, acceptance: true
  validates :has_right_format, acceptance: true
  validates :link, presence: true
  validates :print_quantity,presence: true, numericality: { only_integer: true, greater_than: 0 }

  enum :paper_size, { a2: 'a2', a3: 'a3', a4: 'a4', a5: 'a5', a6: 'a6' }
end
