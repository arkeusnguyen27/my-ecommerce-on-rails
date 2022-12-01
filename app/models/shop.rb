class Shop < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :products, -> {order('created_at desc')}
  has_one :shop_setting

  alias owner user


  def to_s
    name || "Shop id #{id}"
  end


end
