ActiveAdmin.register Product do

  permit_params :name, :category, :description, :price, :buyerId, :soldOut, :user_id , :brand_id
  
index do
  id_column
  column :name
  column :category do |prod|
      prod.categories    
  end
  column :description
  column :brand
  column :price
  column :location do |prod|
    if prod.location 
      prod.location.city.cityName
    end
  end
  column :soldOut
  column :user
  column :updated_at
  actions
end

preserve_default_filters!
filter :user 
filter :soldOut , as: :check_boxes
filter :brand, as: :check_boxes , :collection => proc {(Brand.all).map{|b| [b.brandName, b.id]}}
remove_filter :location
remove_filter :payment
remove_filter :favourites 
remove_filter :users




  #
  # permit_params do
  #   permitted = [:name, :category, :description, :price, :buyerId, :soldOut, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
