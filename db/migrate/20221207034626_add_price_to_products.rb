class AddPriceToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :price, :decimal, default: 0
  end
end
