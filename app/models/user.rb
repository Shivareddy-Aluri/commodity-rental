class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :first_name, :last_name, presence: true
    validates :user_type, inclusion: { in: %w(renter lender)}
end
