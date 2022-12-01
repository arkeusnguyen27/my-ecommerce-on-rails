class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: { message: "must be present"}

  belongs_to :shop

  has_rich_text :description
end


