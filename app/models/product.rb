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

  def has_bought_and_not_reviewed_by?(user)
    line_items.where(buyer: user).where.not(reviewed_at: nil).exists?
  end

  def self.selling_products
    all
  end
end


