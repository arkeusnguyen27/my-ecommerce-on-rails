class ApplicationController < ActionController::Base
  PRODUCTS = {
    1 => { id: 1, shop_id: 1, title: "Awesome book", description: "This is an awesome book from Judge.me" },
    2 => { id: 2, shop_id: 2, title: "Free book", description: "This is a free book from Judge.me" },
  }.freeze

  SHOPS = {
    1 => { id: 1, name: "Shop 1", description: "Awesome shop", banner_url: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg" },
    2 => { id: 2, name: "Shop 2", description: "Free shop", banner_url: "https://www.allkeyshop.com/blog/wp-content/uploads/lost-in-random-800x500-2.jpg" }
  }.freeze

  def not_found
    render "not_found"
  end

  def get_products
    PRODUCTS
  end

  def get_shops
    SHOPS
  end
end
