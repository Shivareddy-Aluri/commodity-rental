class CreateBids < ActiveRecord::Migration[7.2]
  def change
    create_table :bids do |t|
      t.uuid :bid_id
      t.references :listing, null: false, foreign_key: true
      t.references :renter, null: false, foreign_key: { to_table: :users }
      t.decimal :bid_price_month
      t.integer :lease_period
      t.decimal :total_price

      t.timestamps
    end
  end
end
