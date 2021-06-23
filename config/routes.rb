Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # <div style="float:right"><%= link_to 'New Product', new_product_path , class:"newProd"%></div>
  
  get 'locations/index'
  get 'profiles/index'
  get 'payments/index'
  resources :products do 
    resources :locations , only: [:new,:create , :edit , :update]
    resources :payments , only: [:new , :create , :show]
  end
  devise_for :users
  root 'products#index'
  post '/' , to: 'products#index' , as: 'apply_filter'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #payment routes---------------
  get '/products/:id/payment' , to: 'payments#new' , as: 'do_payment'
  post '/products/payment/:id' , to: 'payments#create' , as: 'create_payment'
  get 'products/:id/paymentDetails' , to: 'payments#show' , as: 'view_payment_details'

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

  #Apply Filter


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
      resources :users do
        resources :products
      end
    end
  end
  # namespace :api, defaults: { format: 'json' } do
  #   namespace :v1 do
  #     resources :products 
  #   end
  # end

end
