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

  def self.selling_products
    all
  end
end


