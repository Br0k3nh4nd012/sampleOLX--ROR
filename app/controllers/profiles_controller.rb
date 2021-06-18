class ProfilesController < ApplicationController
  before_action :checkLogin 
  before_action :checkUser , only: %i[ edit , create ]


  def index
    @user = User.find(params[:id])
    @myProducts = @user.products
    @purchasedProduct = Product.where(buyerId: @user.id)
  end
  
  # get '/profile/edit/:id' , to: 'profiles#edit' , as: 'edit_profile'
  def edit
    # @profile = current_user
    @profile = User.find(params[:id])
    @@profile_id = params[:id]
  end

  # patch '/profile/edit' , to: 'profiles#update', as: 'update_profile' 
  def update
    @profile = User.find(@@profile_id)
    
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to view_profile_path(@profile) }
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path
    end
  end

  private 
    def profile_params
      params.require(:user).permit(:name , :email,:mobNumber ,:address)
    end

    #check for is logged in
    def checkLogin
      if current_user
        return true
      else
        redirect_to root_path
      end
    end

    def checkUser
      if current_user.isAdmin or current_user == User.find(params[:id])
        return true
      else
        redirect_to view_profile_path(current_user)
      end
    end
end
