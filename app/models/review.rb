class Review < ApplicationRecord
  belongs_to :user
  belongs_to :line_item

end