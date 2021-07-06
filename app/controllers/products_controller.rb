class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :checkUser, only: %i[ edit update destroy ]
  before_action :validProfile , only: [:new , :create]

  # GET /products or /products.json
  def index    
    if current_user.isAdmin 
      redirect_to ad_home_path
    else
      if params[:category] && params[:category] != 'All categories'
        @products = Product.includes(:location).other_products(current_user).where(category: params[:category] , soldOut:false)
      else
        @products = Product.includes(:location).other_products(current_user).where(soldOut: false)
      end

      if params[:location]
        @locproducts = []
          if params[:location] != 'All Location(city)'
            @products.each do |prod| 
              if prod.location.city == params[:location] 
                @locproducts.push(prod)
              end
            end
            @products = @locproducts
          end
      end
    end
  end

  # GET /products/searchedProducts
  def searchedProducts
    if !params[:search].blank?
      @products = Product.includes(:location).where("name ilike ?","%#{params[:search][:value]}%");
    end
  end




  # GET /products/1 or /products/1.json
  def show
    session[:prod_id] = params[:id]
    begin
      @product = Product.includes(:location).find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:alert] = "Product not found"
      redirect_to root_path
    end
    @valid = validUser
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

    respond_to do |format|
      if @product.save 
        # format.json { render json: "Product was successfully created.", status: :created, location: @product }
        format.html { redirect_to new_product_location_path(@product), notice: "Product was successfully created." }
        # format.json { render json: { success: true }}
        
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
      if !current_user.isAdmin
        format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      else
        format.html { redirect_to ad_products_url, notice: "Product was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      begin 
        @product = Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        puts e
      end
    end


    def checkUser
      if validUser
        return true
      else
        flash[:alert] = "Unauthorized access."
        redirect_to profile_path(current_user)
      end
    end 

    def validProfile
      if current_user.name.blank? || current_user.mobNumber.blank? || current_user.address.blank?
        flash[:alert] = "Invalid profile.Please Update your profile !!"
        redirect_to profile_path(current_user)
      else
        return true
      end
    end

    
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :category, :description, :price)
    end
    
end

