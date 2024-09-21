class Commodity < ApplicationRecord
  belongs_to :lender, class_name: 'User', foreign_key: 'lender_id'

  validates :category, presence: true, inclusion: { in: %w[Electronics Furniture Menswear Womenswear Shoes] }
  validates :name, presence: true
end
