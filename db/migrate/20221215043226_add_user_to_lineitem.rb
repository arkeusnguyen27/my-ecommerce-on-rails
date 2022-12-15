class AddUserToLineitem < ActiveRecord::Migration[6.1]
  def change
    add_reference :line_items, :buyer, foreign_key: { to_table: :users }
    add_reference :line_items, :shop
  end
end
