class CreateRentals < ActiveRecord::Migration[7.2]
  def change
    create_table :rentals do |t|
      t.references :commodity, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true
      t.references :renter, null: false, foreign_key: { to_table: :users }
      t.references :accepted_bid, null: false, foreign_key: { to_table: :bids }
      t.date :start_date
      t.date :end_date
      t.decimal :monthly_rate
      t.integer :lease_period

      t.timestamps
    end
  end
end
