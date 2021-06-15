class LocationsController < ApplicationController
  respond_to :html , :json
  def index
  end
  def new
    @location = Location.new
    @productId = params[:id]
    @locerrors = @location.errors
  end
  def create
    @location = Location.new(location_params)
    @location.product_id = params[:id]
    # respond_to do |format|
      if @location.save
        
        redirect_to root_path 
      # else
        
      #   @locerrors = @location.errors
      #   respond_with(@locerrors)
      #   render :new
      end
    # end
  end

private
  def location_params
    params.require(:location).permit(:city, :state, :country, :postalCode)
  end
end
