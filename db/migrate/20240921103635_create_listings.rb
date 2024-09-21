class CreateListings < ActiveRecord::Migration[7.2]
  def change
    create_table :listings do |t|
      t.references :commodity, null: false, foreign_key: true
      t.references :lender, null: false, foreign_key: { to_table: :users }
      t.decimal :min_monthly_rate
      t.integer :lease_period
      t.string :bid_strategy
      t.boolean :is_active
      t.datetime :expires_at

      t.timestamps
    end
  end
end
