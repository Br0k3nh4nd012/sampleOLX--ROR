class LocationsController < ApplicationController
  
  before_action :authenticate_user!


  def index
  end
  def new
    @location = Location.new
    @productId = params[:product_id]
    # @locerrors = @location.errors
  end
  def create
    @location = Product.find(params[:product_id]).build_location(location_params)
      if @location.save
        flash[:notice] = "Location updated Successfully!!"
        redirect_to root_path 
      else
        flash[:alert] = "Invalid Inputs!!"
        render 'new'
      end
    # end
  end

  def edit
    @location = Product.find(params[:product_id]).location
  end
  def update
    @location = Product.find(params[:product_id]).location
    if @location.update(location_params)
      flash[:notice] = "Location Updated Successfully.!!"
      redirect_to @location.locatable
    else
      flash[:alert] = "Invalid Inputs!!"
      render 'edit'
    end
  end

private
  def location_params
    params.require(:location).permit(:city, :state, :country, :postalCode)
  end

  # def checkLogin
  #   if current_user
  #     return true
  #   else
  #     flash[:alert] = "Unauthorized access.Login Required."
  #     redirect_to root_path
  #   end
  # end
end
