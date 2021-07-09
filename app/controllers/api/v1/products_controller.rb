class Api::V1::ProductsController < ActionController::API

    before_action :doorkeeper_authorize!

    def index
        products = Product.all
        render json:  products 
    end

    def myProducts
        products = User.find_by(@current_user).products
        render json:  products 
    end
    # products = Product.other_products(@current_user)
    

    def show
        product = Product.find(params[:id])
        render json: product
    end


    # /api/v1/users/:user_id/products
    def create
        product = User.find_by(@current_user).products.new(product_params)
        product.brand = Brand.last
        if product.save
            render json: product
        else
            render json: products.errors
            render error: { error: "Unable to create Product!!"}, status: 400
        end
    end

    def update
        product = Product.find(params[:id])
        if product.update(product_params)
            render json: product
        else
            render error: { error: "Unable to update Product!!"}, status: 400
        end
    end
    
    def destroy
        product = Product.find(params[:id])
        if product.destroy
            render json: { message: "successfully destroyed!!" },status:200
        else
            render error: { error: "Unable to destroy Product!!"}, status: 400
        end
    end

    private
    def product_params
        params.permit(:name,:description,:price)
    end

    def current_user
        @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    end
end
