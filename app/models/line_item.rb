class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_one :review
  belongs_to :buyer, class_name: 'User'
  belongs_to :shop

  scope :reviewed, -> { where.not(reviewed_at: nil )}
  scope :not_reviewed, -> { where(reviewed_at: nil )}


  def add(input_quantity)
    if quantity + input_quantity <= 0
      delete
    else
      update(quantity: quantity + input_quantity)
    end
  end

  def update_quantity(input_quantity)
    if input_quantity <= 0
      delete
    else
      update(quantity: input_quantity)
    end
  end

  def sub_total
    quantity * price
  end

  def remove
    delete
  end

  def self.testing(p, u)
    self.where(product: p).not_reviewed.map(&:order).pluck(:user_id).include?(u.id)
  end

  def self.add(user, p, quantity)
    cart = user.cart

    line_item = cart.line_items.find_by(product_id: p.id, order_id: cart.id)

    if line_item.present?
      line_item.add(quantity)
    else
      return self.create(order_id: cart.id, product_id: p.id, price: p.price, quantity: quantity)
    end
  end
end