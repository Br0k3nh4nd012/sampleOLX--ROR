class PaymentsController < ApplicationController
  before_action :checkLogin


  def index
  end
  def show
    # @payment = current_user.payments.where(product_id: params[:id])
    @product = Product.find(params[:id])
    @payment = @product.payment
  end
  def new
    @prod= Product.find(params[:id])
    @price = @prod.price
    @payment = current_user.payments.new
  end

  def create 
    @payment = current_user.payments.new
    @payment.paymentMethod = payment_params
    @payment.price = Product.find(params[:id]).price
    @payment.product_id = params[:id]
    if @payment.save 
      
      redirect_to view_payment_details_path(@payment.product)
    else
      redirect_to do_payment_path(params[:id])
    end

    
  end

  private 
    def payment_params
      params.require(:payment).permit(:paymentMethod)
    end

    def checkLogin
      if current_user
        return true
      else
        redirect_to root_path
      end
    end
end
