class AdminsController < ApplicationController

  before_action :authenticate_user! , :checkAdmin

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
      flash[:notice] = "User created Successfully!!"
      redirect_to ad_users_path
    else
      flash[:alert] = "Enter valid Details!!"
      render 'newUser'
    end
  end

  def products
    @products = Product.includes(:user,:location, [ {:payment => [:user]} ])
  end
  def payments
    @payments = Payment.includes(:user, [ {:product => [:user]} ]).all
  end

  

  
private

  def user_params
    params.require(:user).permit(:email,:password , :password_confirmation , :name,:mobNumber,:address)
  end

  # def checkLogin
  #   if current_user
  #     return true
  #   else
  #     flash[:alert] = "Unauthorized access.Login Required."
  #     redirect_to root_path
  #   end
  # end

  def checkAdmin
    if current_user.isAdmin
      return true
    else
      flash[:alert] = "Unauthorized access."
      redirect_to root_path
    end
  end
end
