class SellerOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_shop?

  def show
    @so = SellerOrder.find_by(id: params[:id], shop: @shop)
    @line_items = LineItem.where(shop: @shop, order: @so.order)
    render redirect_to root_url  unless @so.present?
  end

end