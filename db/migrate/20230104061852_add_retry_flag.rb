class AddRetryFlag < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :retry_disabled, :boolean, default: false
  end
end
