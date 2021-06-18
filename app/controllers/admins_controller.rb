class AdminsController < ApplicationController

  before_action :checkLogin , :checkAdmin

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

  
private
  def checkLogin
    if current_user
      return true
    else
      redirect_to root_path
    end
  end

  def checkAdmin
    if current_user.isAdmin
      return true
    else
      redirect_to root_path
    end
  end
end
