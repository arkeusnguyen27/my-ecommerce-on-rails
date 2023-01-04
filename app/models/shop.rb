class Shop < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_one :shop_setting
  has_many :products, -> {order('created_at desc')}
  has_many :seller_orders, -> {order('created_at desc')}
  after_create :auto_create_shop_setting
  alias owner user

  def to_s
    name || "Shop id #{id}"
  end

  private

  def auto_create_shop_setting
    ShopSetting.create(shop: self)
  end

end
