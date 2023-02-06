class SerialCode < ApplicationRecord
  enum status: { not_applied: 0, applied: 1 }, _prefix: true
  
  belongs_to :campaign
  has_one :application
  
  validates :value, presence: true, uniqueness: { scope: :campaign_id }
  validates :expired_at, presence: true

  scope :order_by_id_desc, -> { order(id: :desc) }
  scope :order_by_id_asc, -> { order(id: :asc) }

  FORMATS = {
    "alphanumeric": "英数字",
    "numeric": "数字のみ"
  }
end
