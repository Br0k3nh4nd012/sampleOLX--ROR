class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user! 
  before_action :checkUser, only: [ :edit, :update, :destroy ]
  # before_action :validProfile , only: [:new , :create]




  # GET /products or /products.json
  def index    
    
    if current_user.isAdmin       
      respond_to do |format|
        format.html { redirect_to ad_home_path  }
        format.csv { send_data ImportExportCSV.new.to_csv , filename: "products-#{Date.today}.csv" }
    end  
      
    else
      if params[:category] && params[:category] != 'All categories'
        @category = Category.find_by(category: params[:category])
        @products = @category.products.other_products(current_user).where(soldOut:false)
      else
      @products = Product.includes(:location ,:brand,:categories_products,:categories).other_products(current_user).where(soldOut: false)
      end

      if params[:brand] && params[:brand] != 'All Brands'
        @products =  @products.where(brand_id: Brand.find_by(brandName: params[:brand]))
      end

      if params[:location]
        @locproducts = []
          if params[:location] != 'All Location(city)'
            @products.each do |prod| 
              if prod.location_city == params[:location] 
                @locproducts.push(prod)
              end
            end
            @products = @locproducts
          end
      end

      
    end  
    @category = categories  
  end


  def import
    ImportExportCSV.new.import(params[:file])
    redirect_to ad_products_url, notice: "Products Uploaded successfully"
   end


  # GET /products/searchedProducts
  def searchedProducts
    if !params[:search].blank?
      @products = Product.includes(:location).where("name ilike ?","%#{params[:search][:value]}%");
    end
  end


  #POST /product/favourite/:id
  def addFavourites
    @favourite = current_user.favourites.new(product_id:params[:id])
    respond_to do |format|
      if @favourite.save
        flash[:notice] = "favourite added!!"
        format.html { redirect_to root_path }
      else
        flash[:alert] = "favourite not added!!"
        format.html { redirect_to root_path , status: :unprocessable_entity}
      end
    end
  end
  # POST /product/favourite/:id
  def removeFavourites
    @favourite = current_user.favourites.find_by(product_id:params[:id])
    respond_to do |format|
      if @favourite.destroy
        flash[:notice] = "favourite removed"
        format.html { redirect_to root_path }
      else
        flash[:alert] = "favourite not removed!!"
        format.html { redirect_to root_path , status: :unprocessable_entity}
      end
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
    @category = categories
  end

  # GET /products/1/edit
  def edit
    @user = Product.find(params[:id]).user
    @category = categories
  end

  # POST /products or /products.json
  def create
    product = current_user.products.new(name: product_params[:name],description:product_params[:description],price:product_params[:price])
    product.brand = Brand.find_by(brandName: product_params[:brand])
    product.categories = Category.where(category:product_params[:category])
    respond_to do |format|
      if product.save 
        format.html { redirect_to new_product_location_path(product), notice: "Product was successfully created."}
        
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @category = categories
    @categories = Category.where(category:product_params[:category])
    @product.categories = @categories
    @product.brand = Brand.find_by(brandName: product_params[:brand])
    respond_to do |format|
      if @product.update(name: product_params[:name],description:product_params[:description],price:product_params[:price])
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
    @product.categories.delete_all
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

    # def checklock
    #   current_user.lock_access!
    #   redirect_to new_user_session_path
    # end

    def checkUser
      if validUser
        return true
      else
        flash[:alert] = "Unauthorized Access!!"
        redirect_to profile_path(current_user)
      end
    end 

    def validProfile
      if current_user.name.blank? || current_user.mobNumber.blank? || current_user.address.blank?
        flash[:alert] = "Invalid profile.Please Update your profile !!"
        redirect_to profile_path(current_user)
        return false
      else
        return true
      end
    end

    def categories
      ["vehicles", "cars", "bikes", "trucks", "auto", "electronics", "TV", "kitchen appliances", "laptops", "mobiles", "tablets", "AC", "computer accessories", "playstation", "books", "gym equipments", "sports equipments", "musical instruments", "furniture", "home appliances", "sofa", "dining", "bed carts", "kids furniture", "other household items", "clocks & watches", "speakers & earphones"]
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, {category:[] }  ,:brand ,:description, :price)
    end
    
end

