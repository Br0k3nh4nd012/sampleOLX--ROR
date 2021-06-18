class AdminsController < ApplicationController

  before_action :checkLogin , :checkAdmin

  def index
  end

  def users
    @users = User.all
  end
  def newUser
    @user = User.new
  end
  def createUser
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render 'newUser'
    end
  end

  def products
    @products = Product.all
  end
  def payments
    @payments = Payment.all
  end

  

  
private

  def user_params
    params.require(:user).permit(:email,:password , :password_confirmation , :name,:mobNumber,:address)
  end

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
