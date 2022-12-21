class Review < ApplicationRecord
  belongs_to :user
  belongs_to :line_item
  validates :rating, presence: true, inclusion: { in: 1..5 }

  after_create :increment_reviews_count
  after_create :update_average_rating
  after_destroy :decrement_reviews_count

  def increment_reviews_count
    Product.increment_counter(:reviews_count, line_item.product.id)
  end

  def update_average_rating
    line_item.product.update_average_rating
  end

  def decrement_reviews_count
    Product.decrement_counter(:reviews_count, line_item.product.id)
  end

end