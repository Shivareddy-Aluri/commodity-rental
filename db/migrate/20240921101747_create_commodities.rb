class CreateCommodities < ActiveRecord::Migration[7.2]
  def change
    create_table :commodities do |t|
      t.references :lender, null: false, foreign_key: { to_table: :users }
      t.string :category
      t.string :name
      t.boolean :is_rented

      t.timestamps
    end
  end
end
