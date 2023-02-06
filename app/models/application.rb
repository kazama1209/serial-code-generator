class Application < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  enum gender: { men: 0, women: 1, other: 2 }, _prefix: true
  
  belongs_to :campaign
  belongs_to :venue
  belongs_to :serial_code
  belongs_to_active_hash :prefecture

  validates :serial_code_id, uniqueness: { scope: :campaign_id, message: "はすでに使用されています" }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :gender, presence: true
  validates :birthdate, presence: true
  validates :postal_code, presence: true
  validates :city, presence: true
  validates :address, presence: true

  scope :order_by_id_desc, -> { order(id: :desc) }
  scope :order_by_id_asc, -> { order(id: :asc) }

  def full_name
    "#{last_name} #{first_name}"
  end

  def full_address
    "〒#{postal_code} #{prefecture.name}#{city}#{address} #{building}"
  end
end
