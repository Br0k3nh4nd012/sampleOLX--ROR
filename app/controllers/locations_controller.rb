class LocationsController < ApplicationController
  respond_to :html , :json
  before_action :checkLogin


  def index
  end
  def new
    @location = Location.new
    @productId = params[:product_id]
    # @locerrors = @location.errors
  end
  def create
    @location = Product.find(params[:product_id]).build_location(location_params)
    # @location.product_id = @@productId
    # respond_to do |format|
      if @location.save
        redirect_to root_path 
      else
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
      redirect_to @location.product
    else
      render 'edit'
    end
  end

private
  def location_params
    params.require(:location).permit(:city, :state, :country, :postalCode)
  end

  def checkLogin
    if current_user
      return true
    else
      redirect_to root_path
    end
  end
end
