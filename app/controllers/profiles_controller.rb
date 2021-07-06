class ProfilesController < ApplicationController
  before_action :authenticate_user! 
  before_action :checkUser , only: %i[ edit , create , destroy ]


  def show
    @user = User.find(params[:id])
    @myProducts = @user.products.includes(:location)
    @purchasedProduct = Product.includes(:payment).where(buyerId: @user.id).order(updated_at: :asc)
    @favProducts = @user.favourite_products
  end
  
  # get '/profile/edit/:id' , to: 'profiles#edit' , as: 'edit_profile'
  def edit
    @profile = User.find(params[:id])
  end

  # patch '/profile/update' , to: 'profiles#update', as: 'update_profile' 
  def update
    @profile = User.find(params[:id])
    
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_path(@profile) }
      else
        flash[:alert] = "unable to update. Please check the data."
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "User destroyed Successfully!!"
      redirect_to ad_users_path
    end
  end

  private 
    def profile_params
      params.require(:user).permit(:name , :email,:mobNumber ,:address)
    end

    #check for is logged in
    # def checkLogin
    #   if user_signed_in?
    #     return true
    #   else
    #     flash[:alert] = "Unauthorized access.Login Required."
    #     redirect_to root_path
    #   end
    # end

    def checkUser
      if current_user.isAdmin or current_user == User.find(params[:id])
        return true
      else
        flash[:alert] = "Unauthorized access."
        redirect_to view_profile_path(current_user)
      end
    end
end
