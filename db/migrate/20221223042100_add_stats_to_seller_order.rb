class AddStatsToSellerOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :seller_orders, :total_amount, :decimal
    add_column :seller_orders, :total_items, :integer
    add_column :seller_orders, :total_line_items, :integer
  end
end
