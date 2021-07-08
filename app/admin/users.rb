ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :mobNumber, :address, :isAdmin

  action_item :block , only: :show do
    link_to "Block" , block_admin_user_path(user) , method: :put unless user.isBlocked
  end
  action_item :block , only: :show do
    link_to "Unblock" , block_admin_user_path(user) , method: :put if user.isBlocked
  end
  
  member_action :block , method: :put do
    user = User.find(params[:id])
    user.update(isBlocked: !user.isBlocked)
    redirect_to admin_user_path(user)
  end

index do
  id_column
  column :email
  column :name
  column :mobNumber , label: 'Mobile Number'
  column :address
  column :isAdmin
  column :isBlocked
  actions
end

preserve_default_filters!
filter :product

  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :mobNumber, :address, :isAdmin]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
