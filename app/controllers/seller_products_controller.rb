class SellerProductsController < DashboardSellerController
  before_action :set_product, only: [:edit, :update]
  before_action :is_shop_owner?, only: [:edit, :update, :destroy]
  before_action :create_new_form_path, only: [:new, :create]
  before_action :create_edit_form_path, only: [:update, :edit]


  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params.merge(shop: @shop))

    respond_to do |format|
      if @product.save
        format.html { redirect_to seller_products_path, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        @path = seller_products_path
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @path = seller_product_path
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to seller_products_url, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_new_form_path
    @path = seller_products_path
  end

  def create_edit_form_path
    @path = seller_product_path
  end
end
