class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def not_found
    render "not_found"
  end

  def is_shop?
    if current_user.present?
      @shop = current_user.shop
    end

    unless @shop.present?
      return respond_to do |format|
        format.html { redirect_to products_url(), notice: "You need to own a shop to create products" }
      end
    end
  end


  def is_buyer?
    unless current_user.present?
      return respond_to do |format|
        format.html { redirect_to new_user_session_url, notice: "You need to login first" }
      end
    end

    unless current_user.buyer?
      return respond_to do |format|
        format.html { redirect_to request.referrer, notice: "You need to login as a buyer" }
      end
    end

  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end

