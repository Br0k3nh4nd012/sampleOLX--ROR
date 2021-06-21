ActiveAdmin.register Location do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :city, :state, :country, :postalCode, :locatable_id, :locatable_type
  
index do
  column :id
  column :city
  column :state
  column :country
  column :postalCode
  column "Product" ,:locatable
    actions
end

filter :city ,as: :check_boxes , collection: ['chennai','madurai','coimbatore','trichy','karur','kochi',]
filter :state , as: :check_boxes , collection: ['tamilnadu','kerala']
  # or
  #
  # permit_params do
  #   permitted = [:city, :state, :country, :postalCode, :locatable_id, :locatable_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
