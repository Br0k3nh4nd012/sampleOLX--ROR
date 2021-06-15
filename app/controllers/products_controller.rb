class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index

    if current_user && current_user.isAdmin
      redirect_to admin_home_path
    elsif current_user
      @products = Product.all.where.not(user_id: current_user.id )
    else
      redirect_to new_user_session_path
    end
  end

  # GET /products/1 or /products/1.json
  def show
    session[:prod_id] = params[:id]
    @product = Product.find(params[:id])
    @location = @product.location
  end

  # GET /products/new
  def new

    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @user = Product.find(params[:id]).user

  end

  # POST /products or /products.json
  def create
    @user = current_user
    @product = @user.products.new(product_params)
    @product.soldOut = false

    respond_to do |format|
      if @product.save 
        
        format.html { redirect_to fill_location_path(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        if current_user.isAdmin
          format.html { redirect_to admin_products_path, notice: "Product was successfully updated." }
        else
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        end
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :category, :description, :price)
    end
    
end
