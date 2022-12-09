class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items


  def complete
    if can_checkout?
      update(status: 'completed')
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