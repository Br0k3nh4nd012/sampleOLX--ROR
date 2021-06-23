ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :category, :description, :price, :buyerId, :soldOut, :user_id
  
index do
  column :id
  column :name
  column :category
  column :description
  column :price
  column :location do |prod|
    prod.location.city
  end
  column :soldOut
  column :user
  column :updated_at
end

filter :user 
filter :location, as: :select , collection: ['chennai']
  # or
  #
  # permit_params do
  #   permitted = [:name, :category, :description, :price, :buyerId, :soldOut, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
