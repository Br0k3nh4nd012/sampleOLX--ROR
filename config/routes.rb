Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root 'products#index'

  resources :products do 
    resources :locations , only: [:new,:create , :edit , :update]
    resources :payments , only: [:new , :create , :show]
  end

  #searchbar routes-------------------
  post '/products/searchedProducts' , to: 'products#searchedProducts' , as: 'searched_products'
  get '/products/searchedProducts' , to: 'products#searchedProducts'

  post 'product/add_favourite/:id' , to: 'products#addFavourites', as: 'add_favourites'
  post 'product/remove_favourite/:id'  , to:'products#removeFavourites',as: 'remove_favourites'

  #filterBar route--------------------
  post '/' , to: 'products#index' , as: 'apply_filter'

  #profile routes----------------
  resources :profiles , only: [:show , :edit , :update , :destroy]
  

  #admin routes-----------
  get 'ad/index' , to: 'admins#index', as: 'ad_home'
  get 'ad/users', to: 'admins#users', as: 'ad_users'
  get 'ad/products', to: 'admins#products', as: 'ad_products'
  get 'ad/payments', to: 'admins#payments', as: 'ad_payments'
  get 'ad/new_user', to: 'admins#newUser', as: 'ad_new_user'
  post 'ad/create_user' , to: 'admins#createUser', as: 'ad_create_user'






  # API routes--------------------------------------------
  namespace :api do
    namespace :v1 do      
        resources :products              
    end
  end
  get 'api/v1/my_products' , to: 'api/v1/products#myProducts' , as: 'api_v1_myProducts'


  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

end





# My References---------------------------------------------------

#location routes-----------------
  # get '/products/:id/location' , to: 'locations#new' , as: 'fill_location'
  # post '/products/locationadd', to: 'locations#create' ,as: 'add_location'
  # get '/products/:id/location/edit' , to: 'locations#edit' ,as: 'edit_location'
  # patch '/products/location' , to: 'locations#update' ,as: 'update_location'



#payment routes---------------
  # get '/products/:id/payment' , to: 'payments#new' , as: 'do_payment'
  # post '/products/payment/:id' , to: 'payments#create' , as: 'create_payment'
  # get 'products/:id/paymentDetails' , to: 'payments#show' , as: 'view_payment_details'
  


#profile routes----------------
  # get '/profile/:id' , to: 'profiles#index' , as: 'view_profile'
  # get '/profile/edit/:id' , to: 'profiles#edit' , as: 'edit_profile'
  # patch '/profile/update/:id' , to: 'profiles#update', as: 'update_profile' 
  # delete '/profile/delete/:id' , to: 'profiles#destroy' , as: 'destroy_profile'