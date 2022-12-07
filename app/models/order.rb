class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items


  def complete
    update(status: 'completed')
  end
end