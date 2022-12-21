class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items

  scope :completed, -> { where(status: 'completed')}

  def complete
    if can_checkout?
      update(status: 'completed')
      # Run job to increment purchase count
      line_items.each do |line_item|
        Product.increment_counter(:purchases_count, line_item.product.id)
      end
    else
      false
    end
  end

  def can_checkout?
    status == 'cart' && line_items.count != 0
  end


  def count_line_items
    line_items.count
  end

  def count_items
    line_items.collect { |line_item| line_item.quantity}.sum
  end

  def total
    line_items.collect { |line_item| line_item.quantity * line_item.price }.sum
  end
end
