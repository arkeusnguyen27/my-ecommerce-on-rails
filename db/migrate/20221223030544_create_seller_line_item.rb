class CreateSellerLineItem < ActiveRecord::Migration[6.1]
  def change
    create_table :seller_line_items do |t|
      t.integer  :quantity
      t.decimal  :price
      t.datetime :reviewed_at
      t.belongs_to :line_item
      t.belongs_to :product
      t.belongs_to :buyer, foreign_key: { to_table: :users }
      t.belongs_to :shop

      t.timestamps
    end
  end
end
