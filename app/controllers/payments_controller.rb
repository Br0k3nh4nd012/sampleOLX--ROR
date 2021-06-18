class PaymentsController < ApplicationController
  def index
  end
  def show
    # @payment = current_user.payments.where(product_id: params[:id])
    @product = Product.find(params[:id])
    @payment = @product.payment
  end
  def new
    # @prodId = params[:id]
    @price = Product.find(params[:id]).price
    @payment = current_user.payments.new
  end

  def create 
    @payment = current_user.payments.new
    @payment.paymentMethod = payment_params
    @payment.price = Product.find(session[:prod_id]).price
    @payment.product_id = session[:prod_id]
    if @payment.save 
      @prod = Product.find(session[:prod_id])
      @prod.buyerId = current_user.id
      @prod.soldOut = true
      @prod.save
      redirect_to view_payment_details_path(@payment.product)
    else
      render 'new'
    end

    
  end

  private 
    def payment_params
      params.require(:payment).permit(:paymentMethod)
    end
end
