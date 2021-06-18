Rails.application.routes.draw do
  
  get 'locations/index'
  get 'profiles/index'
  get 'payments/index'
  resources :products do 
    resources :locations , only: [:new,:create , :edit , :update]
  end
  devise_for :users
  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #payment routes---------------
  get '/products/:id/payment' , to: 'payments#new' , as: 'do_payment'
  post '/products/payment/:id' , to: 'payments#create' , as: 'create_payment'
  get '/:id/paymentDetails' , to: 'payments#show' , as: 'view_payment_details'

  #profile routes----------------
  get '/profile/:id' , to: 'profiles#index' , as: 'view_profile'
  get '/profile/edit/:id' , to: 'profiles#edit' , as: 'edit_profile'
  patch '/profile/edit' , to: 'profiles#update', as: 'update_profile' 
  delete '/profile/delete/:id' , to: 'profiles#destroy' , as: 'destroy_profile'

  #location routes-----------------
  # get '/products/:id/location' , to: 'locations#new' , as: 'fill_location'
  # post '/products/locationadd', to: 'locations#create' ,as: 'add_location'
  # get '/products/:id/location/edit' , to: 'locations#edit' ,as: 'edit_location'
  # patch '/products/location' , to: 'locations#update' ,as: 'update_location'

  #admin routes-----------
  get 'admins/index' , to: 'admins#index', as: 'admin_home'
  get 'admin/users', to: 'admins#users', as: 'admin_users'
  get 'admin/products', to: 'admins#products', as: 'admin_products'
  get 'admin/payments', to: 'admins#payments', as: 'admin_payments'
end
