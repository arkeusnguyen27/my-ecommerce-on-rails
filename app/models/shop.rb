class Shop < ApplicationRecord
  belongs_to :user
  has_many :products

  alias owner user


  def to_s
    name || "Shop id #{id}"
  end
end
