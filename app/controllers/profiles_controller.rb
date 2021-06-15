class ProfilesController < ApplicationController
  def index
    @user = User.find(params[:id])
    @myProducts = @user.products
    @purchasedProduct = Product.where(buyerId: @user.id)
  end

  def edit
    # @profile = current_user
    @profile = User.find(params[:id])
    @@profile_id=@profile.id
  end

  def update
    @profile = User.find(@@profile_id)
    if @profile.update(profile_params)
      redirect_to view_profile_path(@profile)
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
end
