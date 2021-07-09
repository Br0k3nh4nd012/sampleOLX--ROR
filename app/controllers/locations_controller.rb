class LocationsController < ApplicationController
  
  before_action :authenticate_user!

  def new
    @location = Location.new    
  end
  def create
    @location = Product.find(params[:product_id]).build_location(postalCode: location_params[:postalCode])
    @location.city = City.find_city(location_params[:city])
    @location.state = State.find_state(location_params[:state])
    @location.country = Country.find_country(location_params[:country])
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
    @location.city = City.find_city(location_params[:city])
    @location.state = State.find_state(location_params[:state])
    @location.country = Country.find_country(location_params[:country])
    @location.postalCode = location_params[:postalCode]
    if @location.save
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

end
