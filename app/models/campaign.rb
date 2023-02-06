class Campaign < ApplicationRecord
  has_many :serial_codes
  has_many :applications
  has_many :venues
  
  validates :title, presence: true

  scope :order_by_id_desc, -> { order(id: :desc) }
end
