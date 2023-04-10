class DashboardController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:toggle_featured_products]
  before_action :authenticate_shop, only: [:toggle_featured_products]
  
  def seller_dashboard
  end

  def buyer_dashboard
  end
  

  def index
    if current_user.seller?
      @paths = [
        {name: 'Products', path: 'products'},
        {name: 'Orders', path: 'orders'},
      ]
      case params[:view_param]
      when 'products'
        @view_template = 'products_content'
      when 'orders'
        @view_template = 'orders_content'
      else
        @view_template = 'main_content'
      end

      render 'seller_dashboard'
    else
      @paths = [
        {name: 'Orders', path: 'orders'}
      ]
      # @view_template = params[:view_param].present? ? 'orders_content' : 'main_content' use this when buyer has more contents
      @view_template = 'orders_content' #temporarily use this because buyer only has order content
      render 'buyer_dashboard'
    end
  end



  def toggle_featured_products
    checked_product_ids = params[:checked_product_ids].uniq
    unchecked_product_ids = params[:unchecked_product_ids].uniq

    validated_checked_product_ids = @shop.products.where(id: checked_product_ids).pluck(&:id)
    validated_unchecked_product_ids = @shop.products.where(id: unchecked_product_ids).pluck(&:id)

    if checked_product_ids.count != validated_checked_product_ids.count || unchecked_product_ids.count != validated_unchecked_product_ids.count
      return render json: {
        status: 'error'
      }
    end

    if !@shop_setting.featured_products.present?
      @shop_setting.featured_products = checked_product_ids
    else
      @shop_setting.featured_products = @shop_setting.featured_products - unchecked_product_ids
      @shop_setting.featured_products = @shop_setting.featured_products + checked_product_ids
      @shop_setting.featured_products = @shop_setting.featured_products.uniq
    end

    @shop_setting.save

    # uncheck products
    @shop.products.where(id: unchecked_product_ids).update_all(featured: false)
    # check products
    @shop.products.where(id: checked_product_ids).update_all(featured: true)
    render json: {
      status: 'ok'
    }
  end

  def authenticate_shop
    @shop = current_user.shop
    @shop_setting = @shop.shop_setting
  end
end
