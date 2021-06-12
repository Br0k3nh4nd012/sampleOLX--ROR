class ProfilesController < ApplicationController
  def index
    @myProducts = current_user.products
    @purchasedProduct = Product.where(buyerId: current_user.id)
  end

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update(profile_params)
      redirect_to view_profile_path
    else
      redirect_to view_profile_path
    end
  

  end


  private 
    def profile_params
      params.require(:user).permit(:name , :email,:mobNumber ,:address)
    end
end
