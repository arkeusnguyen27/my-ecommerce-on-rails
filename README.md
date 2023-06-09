# Simple ecommerce platform

## User stories

## Admins/Owners

## Users
~~- Should be able to register/login/logout account~~
~~- user chooses a role ['buyer', 'seller']~~
    ~~- create account~~
    ~~- if register as a seller => we automatically create a shop for seller (with default info)~~

## Sellers
- ~~Dashboard~~
- ~~Should be able to create product to sell (prices, images, title, body)~~
- ~~Should be able to list products on their own shop page.~~
  - ~~setting page: allow seller to select listing products~~
  - ~~Create shop page => shows~~ [~~shop's products~~, reviews]
- Should be able to set product status (selling, pending, draft, archive)
  - ~~Should be to see orders (related to his products only) - how much $, quantity,~~ price
- Have some statistics for each product (stock, sold,  rev ) - in a specific time range


## Buyers
- ~~Should be able to browse products~~
  - by categories
- ~~Should be able to browse products from a specific shop~~
- ~~Should be able to buy products (multiple items)~~
  ~~- Have cart page, update items~~
~~- Should be able to see historical purchases/orders~~ 



## Reviews
- Buyers who purchased products can leave reviews for them.
  - Seller should be able to send review request to buyers for purchased products
  - Reminder request for review
- Should be able to review products
- Extra: allow sellers to showcase some reviews on their homepage


## Emails
~~- Send welcome email to seller~~
~~- Send notification email to seller when someone buys their products~~
~~- Send review request to buyer~~
- Send review request reminder to buyer (retry [every week], maximum [2 times])


## Restful route
~~- /shops~~
~~- /shops/:shop_slug/products~~
~~- /shops/:shop_slug/products/:product_slug~~
