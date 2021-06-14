class AdminsController < ApplicationController
  def index
  end

  def users
    @users = User.all
  end
  def products
    @products = Product.all
  end
  def payments
    @payments = Payment.all
  end
end
