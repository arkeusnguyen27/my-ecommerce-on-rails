class DashboardSellerController < DashboardController
  before_action :routes
  before_action :authenticate_shop
  

  layout "dashboard_seller"

  def routes
    @paths = [{name: 'Products', path: 'products'}]
  end


  def is_shop_owner?
    # check if login shop == product.shop
    product_id = Product.friendly.find(params[:id]).shop_id
    unless @shop.id == product_id
      redirect_to dashboard_view_dashboard_index_url, notice: "You're not the owner of this product"
    end
  end
  
  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :cover, :price)
  end
end
