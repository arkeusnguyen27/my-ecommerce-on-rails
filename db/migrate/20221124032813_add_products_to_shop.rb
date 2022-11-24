class AddProductsToShop < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :shop, foreign_key: true, index: true, null: false
  end
end
