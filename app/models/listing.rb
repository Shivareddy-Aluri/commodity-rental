class Listing < ApplicationRecord
  belongs_to :commodity
  belongs_to :lender, class_name: 'User', foreign_key: 'lender_id'

  validates :min_monthly_rate, :lease_period, :bid_strategy, :expires_at, presence: true
  validates :min_monthly_rate, numericality: { greater_than: 0 }
  validates :lease_period, numericality: { only_integer: true, greater_than: 0 }
  validates :bid_strategy, inclusion: { in: %w[highest_price highest_overall] }
end
