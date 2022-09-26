Rails.application.routes.draw do

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end
  
  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "customers/registrations",
    sessions: 'customers/sessions'
  }

  root to: "customers/homes#top"
  
  post '/customers/homes/guest_sign_in', to: 'customers/homes#guest_sign_in'

  post '/orders/confirm' => 'customers/orders#confirm'
  get '/orders/complete' => 'customers/orders#complete'

  get 'items/search/:id' => 'items#search'
  delete '/cart_items/destroy_all' => 'customers/cart_items#destroy_all'

  get '/customers' => 'customers/customers#show'
  get '/customers/:id/edit' => 'customers/customers#edit', as: :customer_edit
  patch '/customers' => 'customers/customers#update'
  get '/customers/unsubscribe' => 'customers/customers#unsubscribe'
  patch '/customers/withdraw' => 'customers/customers#withdraw'
  resources :customers, only: [:index, :show, :edit, :update]


  namespace :admins do
    get '' => 'homes#top'

   ## resources :orders, only: [:show, :update]
    ##patch 'order_details/:id' => 'order_details#update', as:'order_detail'

    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :update]
    resources :items, only: [:index, :show, :edit, :update, :destroy]
  end

  scope module: 'customers' do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    resources :cart_items, only: [:update, :create, :index, :destroy]
    resource :bookmarks, only: [:show]
    resources :items, only: [:index, :show, :new, :create, :edit] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      resource :bookmarks, only: [:show, :create, :destroy]
    end
    resources :products, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
  end

end
