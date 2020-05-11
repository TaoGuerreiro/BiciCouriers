 Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  match 'profil', to: 'users#show', via: 'get'
  mount StripeEvent::Engine, at: '/stripe-webhooks'

  get "/histoire", to: "pages#story"
  get "/tarifs", to: "pages#tarifs"
  get "/about", to: "pages#about"


  resources :shopping_carts, only: [:show, :create]

  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end


  resources :services, only: [:index, :show]

  resources :avantages, only: [:index]

  resources :contacts, only: [:new, :create]

  resources :courses, only: [:new, :create, :index, :show, :destroy] do
    resources :drops, only: [ :new, :create ]
    resources :pickups, only: [ :new, :create ]
  end

  resources :favorite_addresses, only: [:new, :create, :index, :show, :destroy]

  resources :carnets, only: [:new, :create, :index, :show, :destroy] do
    collection do
      get :inprogress
    end
    collection do
      get :finished
    end
  end

end
