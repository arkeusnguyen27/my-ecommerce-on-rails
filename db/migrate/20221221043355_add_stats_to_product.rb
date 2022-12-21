class AddStatsToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :reviews_count, :integer, default: 0, null: false
    add_column :products, :average_rating, :decimal
  end
end
