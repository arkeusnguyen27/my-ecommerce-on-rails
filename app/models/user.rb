class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :shop
  has_many :orders
  has_many :reviews
  has_many :line_items, foreign_key: :buyer_id
  has_many :blogs
  has_many :votes

  def cart
    orders.find_or_create_by(status: 'cart')
  end

  def completed_orders
    orders.where(status: 'completed')
  end
  def name
    email.split('@').first
  end
  def buyer?
    role == 'buyer'
  end

  def has_bought_product?(p)
    line_items.where(product: p).exists?
  end
  def seller?
    role == 'seller'
  end

  def get_number_of_all_like_votes
    sum = 0
    blogs.each do |blog|
      sum = sum + blog.get_number_of_all_like_votes
    end
    return sum
  end

  def get_number_of_all_dislike_votes
    sum = 0
    blogs.each do |blog|
      sum = sum + blog.get_number_of_all_dislike_votes
    end
    return sum
  end
end
