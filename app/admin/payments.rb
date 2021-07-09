ActiveAdmin.register Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :paymentMethod, :user_id, :product_id
 

index do
  selectable_column
  column :id
  column :paymentMethod
  column :amount  do |payment|
    payment.product.price
  end
  column :user
  column :product
  actions
end

preserve_default_filters!
filter :user
filter :paymentMethod , as: :select , collection: ['Net banking','Debit card']
# filter :price , as: :numeric

  #
  # or
  #
  # permit_params do
  #   permitted = [:paymentMethod, :price, :user_id, :product_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
