ActiveAdmin.register Location do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :city, :state, :country, :postalCode, :locatable_id, :locatable_type
  
index do
  selectable_column
  id_column
  column :city 
  column :state
  column :country
  column :postalCode
  column "Product" ,:locatable
    actions
end



preserve_default_filters!
# filter :city , as: :select 
filter :city ,as: :check_boxes , :collection => proc {(City.all).map{|l| [l.cityName, l.id]}}
filter :state , as: :check_boxes , :collection => proc {(State.all).map{|l| [l.stateName, l.id]}}
filter :country , as: :check_boxes , :collection => proc {(Country.all).map{|l| [l.countryName, l.id]}}

  # or
  #
  # permit_params do
  #   permitted = [:city, :state, :country, :postalCode, :locatable_id, :locatable_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
