class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items

  scope :completed, -> { where(status: 'completed')}

  def complete
    if can_checkout?
      update(status: 'completed')
      # Run job to increment purchase count
      shop_ids = []
      line_items.each do |line_item|
        Product.increment_counter(:purchases_count, line_item.product.id)
        shop_ids << line_item.shop_id
      end
      shop_ids = shop_ids.uniq
      shop_ids.each do |shop_id|
        SellerOrder.create_order(shop_id, self)
      end

      # send review request email (after 7 days)
      BuyerMailer.with(order_id: id).first_request_to_review_email.deliver_later()

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

  def is_buyer_order_completed?

    so = SellerOrder.find_by(order_id: line_items[0].order_id)
    if so.status == 'completed' 
      return true
    end
    return false

  end
end
