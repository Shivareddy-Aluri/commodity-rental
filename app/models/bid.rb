class Bid < ApplicationRecord
  belongs_to :listing
  belongs_to :renter, class_name: 'User'

  validates :bid_price_month, presence: true, numericality: { greater_than: 0 }
  validates :lease_period, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
