class Venue < ApplicationRecord
  belongs_to :campaign
  has_many :applications

  validates :name, presence: true

  scope :order_by_id_desc, -> { order(id: :desc) }
  scope :order_by_id_asc, -> { order(id: :asc) }
end
