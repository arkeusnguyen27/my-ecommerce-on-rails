class DashboardController < ApplicationController
  before_action :authenticate_user!

  def seller_dashboard

  end

  def buyer_dashboard

  end

  def index

    if current_user.seller?
      @paths = [{name: 'Products', path: 'products'}]
      @view_template = params[:view_param].present? ? 'product_content' : 'main_content'
      render 'seller_dashboard'
    else
      render 'buyer_dashboard'
    end
  end
end