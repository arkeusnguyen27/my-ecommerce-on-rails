class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :shop
  has_many :orders


  def cart
    orders.find_or_create_by(status: 'cart')
  end
  def buyer?
    role == 'buyer'
  end

  def seller?
    role == 'seller'
  end
end
