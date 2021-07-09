class PaymentsController < ApplicationController
  before_action :authenticate_user!


  def show
    @product = Product.find(params[:product_id])
    @payment = @product.payment
  end
  def new
    @prod= Product.find(params[:product_id])
    @price = @prod.price
    @payment = current_user.payments.new
  end

  def create 
    payment = current_user.payments.new
    payment.paymentMethod = payment_params
    payment.product_id = params[:product_id]
    if payment.save 
      prod = Product.find(params[:product_id])
      if prod.update(buyerId: payment.user.id , soldOut: true)
        flash[:notice] = "Payment Success!!"
        redirect_to product_payment_path(product_id: payment.product , id: payment)
      end
    else
      flash[:alert] = "Payment failed!!"
      redirect_to new_product_payment_path(params[:product_id])
    end    
  end

  private 
    def payment_params
      params.require(:payment).permit(:paymentMethod)
    end

    
end
