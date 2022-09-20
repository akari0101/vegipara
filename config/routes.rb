Rails.application.routes.draw do


  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "customers/registrations",
    sessions: 'customers/sessions'
  }

  root to: "customers/homes#top"
  
  post '/orders/confirm' => 'customers/orders#confirm'
  get '/orders/complete' => 'customers/orders#complete'

  get 'items/search/:id' => 'items#search'
  delete '/cart_items/destroy_all' => 'customers/cart_items#destroy_all'

  get '/customers' => 'customers/customers#show'
  get '/customers/edit' => 'customers/customers#edit'
  patch '/customers' => 'customers/customers#update'
  get '/customers/unsubscribe' => 'customers/customers#unsubscribe'
  patch '/customers/withdraw' => 'customers/customers#withdraw'


  namespace :admins do
    get '' => 'homes#top'

   ## resources :orders, only: [:show, :update]
    ##patch 'order_details/:id' => 'order_details#update', as:'order_detail'

    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :update]
    resources :products, only: [:index, :show, :edit, :update]
  end

  scope module: 'customers' do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    resources :cart_items, only: [:update, :create, :index, :destroy]
    resources :items, only: [:index, :show]
    resources :products, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :comments, only: [:create, :destroy]
  end

end
