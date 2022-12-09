class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_buyer?


  def create
    product = Product.selling_products.find_by(id: line_item_params[:product_id])
    return unless product.present?

    LineItem.add(current_user, product, line_item_params[:quantity].to_i)
  end


  # Only allow a list of trusted parameters through.
  def line_item_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end
