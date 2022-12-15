class CreateReview < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :review_type, default: 'product'
      t.belongs_to :user
      t.belongs_to :line_item
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
