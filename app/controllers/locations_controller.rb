class LocationsController < ApplicationController
  def index
  end
  def new
    @location = Location.new
    @productId = params[:id]
  end
  def create
    @loc = Location.new(location_params)
    @loc.product_id = params[:id]
    if @loc.save
      redirect_to root_path
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @loc.errors, status: :unprocessable_entity }
    end
  end

  def location_params
    params.require(:location).permit(:city, :state, :country, :postalCode)
  end
end
