class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: { message: "must be present"}

  belongs_to :shop
  has_many :line_items

  has_one_attached :cover
  has_rich_text :description

  def self.public_products
    self.all
  end

  def completed_reviews
    line_items.reviewed.map(&:review)
  end

  def has_bought_by?(user)
    line_items.where(buyer: user).exists?
  end

  def update_average_rating
    total_rating = 0
    count_valid_review_with_rating = 0
    line_items.each do |item|
      if item.review.present? && item.review.rating.present?
        total_rating += item.review.rating
        count_valid_review_with_rating += 1
      end
    end

    self.average_rating = '%.1f' % (total_rating.to_f / count_valid_review_with_rating)
    self.save
  end

  def self.update_average_rating
    self.find_each do |product|
      product.update_average_rating
    end
  end

  def has_bought_and_not_reviewed_by?(user)
    if line_items.where(buyer: user).where(reviewed_at: nil).exists?
      line_item_order_id = line_items.find_by(buyer: user).order_id
      so = SellerOrder.find_by(order_id: line_item_order_id)
      if !so.nil? && so.status == 'completed'
        return true
      end
    end
    return false
  end

  def self.selling_products
    all
  end

  def self.update_reviews_count
    self.find_each do |product|
      product.reviews_count = product.line_items.where.not(reviewed_at: nil).count
      product.save
    end
  end

  def self.update_purchases_count
    self.find_each do |product|
      product.update_purchases_count
    end
  end

  def update_purchases_count
    orders_count = 0
    line_items.each do |li|
      if li.order.status == 'completed'
        orders_count += 1
      end
    end
    self.purchases_count = orders_count
    self.save
  end

  def update_reviews_count
    self.reviews_count = line_items.where(reviewed_at: nil).count
    self.save
  end

  def self.ransackable_associations(auth_object = nil)
    ["cover_attachment", "cover_blob", "line_items", "rich_text_description", "shop"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["average_rating", "created_at", "description", "featured", "id", "price", "purchases_count", "reviews_count", "shop_id", "slug", "title", "updated_at"]
  end
  
end


