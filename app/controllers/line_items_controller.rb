class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_buyer?


  def create
    product = Product.selling_products.find_by(id: line_item_params[:product_id])
    return unless product.present?

    LineItem.add(current_user, product, line_item_params[:quantity].to_i)
  end

  def destroy
    line_item = LineItem.find(params[:id])
    redirect_to root_url and return unless current_user == line_item.order.user && line_item.order.status == 'cart'

    if line_item.delete
      #line_item.price = line_item.price - line_item.delete.price
      @line_items = line_item.order.reload.line_items
    else
      render "error", error_message: "cannot delete item from cart"
    end
  end

  def update
    @line_item = LineItem.find(params[:id])
    redirect_to root_url and return unless current_user == @line_item.order.user && @line_item.order.status == 'cart'

    @line_item.update_quantity(line_item_params[:quantity].to_i)
  end

  # Only allow a list of trusted parameters through.
  def line_item_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end
