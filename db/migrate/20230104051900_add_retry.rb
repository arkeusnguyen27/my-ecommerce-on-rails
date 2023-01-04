class AddRetry < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :sending_reminder_retry_count, :integer, default: 3
    add_column :line_items, :retry_count, :integer, default: 0
  end
end
