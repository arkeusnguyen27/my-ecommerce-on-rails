class AddReviewedAtToLineitem < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :reviewed_at, :datetime
  end
end
