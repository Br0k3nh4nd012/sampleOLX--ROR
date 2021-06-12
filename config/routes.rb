Rails.application.routes.draw do
  get 'profiles/index'
  get 'payments/index'
  resources :products
  devise_for :users
  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #payment routes---------------
  get '/products/:id/payment' , to: 'payments#new' , as: 'do_payment'
  post '/products/payment' , to: 'payments#create'
  get '/:id/paymentDetails' , to: 'payments#show' , as: 'view_payment_details'

  #profile routes----------------
  # resources :profiles
  get '/profile' , to: 'profiles#index' , as: 'view_profile'
  post '/profile/update' , to: 'profiles#update' 
  get '/profile/edit' , to: 'profiles#edit' , as: 'edit_profile'
  patch '/profile/edit' , to: 'profiles#update' 
end
