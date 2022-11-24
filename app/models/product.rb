class Product < ApplicationRecord
  validates :title, presence: { message: "must be present"}

  belongs_to :shop

  has_rich_text :description
end


