class Rental < ApplicationRecord
    belongs_to :commodity
    belongs_to :listing
    belongs_to :renter, class_name: 'User'
    belongs_to :accepted_bid, class_name: 'Bid'

    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :monthly_rate, numericality: { greater_than_or_equal_to: 0 }
    validates :lease_period, numericality: { only_integer: true, greater_than: 0 }
end
