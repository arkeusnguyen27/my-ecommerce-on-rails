class SellerOrder < ApplicationRecord
  belongs_to :shop
  belongs_to :order



  def self.create_order(shop_id, order)
    line_items = order.line_items.from_shop(shop_id)
    total_items = 0
    total_amount = 0
    total_line_items = 0
    line_items.each do |line_item|
      total_line_items += 1
      total_items += line_item.quantity
      total_amount += line_item.quantity * line_item.price
    end
    shop = Shop.find(shop_id)
    new_order = self.new(
      shop: shop,
      order: order,
      total_items: total_items,
      total_amount: total_amount,
      total_line_items: total_line_items
    )

    if new_order.save
      SellerMailer.with(seller: shop.owner, order: new_order).send_order_notification_email.deliver_later
    end

  end

  def is_order_completed?(user)
    self.where(buyer: user).where(order_id).exists? 
  end

  def calculate_total_items
    #sum of  each_line_item * quantity
  end

  def calculate_total_amount
    #sum of each_line_item * quantity * price
  end

  def calculate_total_line_items
    #sum of each_line_item
  end
end