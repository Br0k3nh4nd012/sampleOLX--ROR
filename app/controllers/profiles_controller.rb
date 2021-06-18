class ProfilesController < ApplicationController
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
end
