ActiveAdmin.register User do

  # active_admin_paranoia
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :mobNumber, :address, :isAdmin , :isBlocked , :deleted_at , :password , :password_confirmation


  # attribute name isBlocked should be changed to is_blocked

  action_item :blocked , only: :show do
    if user.isBlocked
      link_to "Unblock" , block_admin_user_path(user) , method: :put 
    else
      link_to "Block" , block_admin_user_path(user) , method: :put 
    end
  end  
 
  member_action :block , method: :put do
    user = User.find(params[:id])
    user.update(isBlocked: !user.isBlocked)
    redirect_to admin_user_path(user)
  end

  action_item :soft , only: :index do
    user = User.last
    if !User.only_deleted.empty?
      link_to "Undo Delete" , soft_admin_users_path
    end
end 

  collection_action :soft  do 
    User.only_deleted.last.restore
    redirect_to admin_users_path
  end


  form do |f|
    f.inputs do 
      f.input :email 
      f.input :password
      f.input :password_confirmation
      f.input :name
      f.input :mobNumber
      f.input :address
    end
    f.actions 
  end

#  use 
index do
  id_column
  column :email
  column :name
  column :mobNumber , label: 'Mobile Number'
  column :address
  column :isAdmin
  column :isBlocked
  column :deleted_at
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




  action_item :delete_user, :only => :show do 
    link_to "Delete user", delete_admin_user_path(resource), method: :delete
  end
  
  member_action :delete, method: :delete do
    resource.destroy
    redirect_to admin_users_path
  end

  scope :deleted, show_count: false
  
end
