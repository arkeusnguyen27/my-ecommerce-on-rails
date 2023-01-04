class CreateSellerOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :seller_orders do |t|
      t.belongs_to :shop
      t.belongs_to :buyer, foreign_key: { to_table: :users}
      t.string :status
      t.belongs_to :order

      t.timestamps
    end
  end
end
