class Api::V1::ProductsController < ActionController::API

    def index
        @products = User.find(params[:user_id]).products
        render json:  @products 
    end

    def show
        @product = Product.find(params[:id])
        render json: @product
    end


    # /api/v1/users/:user_id/products
    def create
        @product = User.find(params[:user_id]).products.new(product_params)
        if @product.save
            render json: @product
        else
            render error: { error: "Unable to create Product!!"}, status: 400
        end
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            render json: @product
        else
            render error: { error: "Unable to create Product!!"}, status: 400
        end
    end
    
    def destroy
        @product = Product.find(params[:id])
        if @product.destroy
            render json: { message: "successfully destroyed!!" },status:200
        else
            render error: { error: "Unable to destroy Product!!"}, status: 400
        end
    end

    private
    def product_params
        params.permit(:name,:category,:description,:price)
    end
end

# module Api
#     module V1
#         class ProductsController < ApplicationController
#             protect_from_forgery with: :null_session
#             respond_to :json

#             def index
#             respond_with Product.all
#             end

#             def create
      
#                 puts "oeihheoihroierhoiehoiwihow
              
              
#                 #{params}
              
#                oegruegriuwegriueg "
              
#               respond_with Product.create(product_params)
              
#               end  
              
#               def show
#                 respond_with Product.find(params[:id])
#               end  
              
#               def destroy
#                 if Product.find_by(id: params[:id]).nil?
#                   respond_with "Cant find the data"
#                 else
#                   respond_with Product.find(params[:id]).destroy
#                 end
#               end
              
              
#               def update
#                 product=Product.find(params[:id])
#                 product.update(name:params[:name])
#                 puts "kfuugu
#                 fyfyfy
#                 ifyiyf"
              
              
#                 puts product.errors.full_messages
#               end  
              
#               private 
#               def  product_params
#                 res={}
#                 res[:name] = params[:name]
#                 res[:category]=params[:category]
#                 res[:description]=params[:description]
#                 res[:user_id]=params[:user_id]
#                 res[:price]=params[:price]
#                 return res
#               end 

            
        

#         end
#     end
# end