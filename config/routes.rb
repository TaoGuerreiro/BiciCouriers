 Rails.application.routes.draw do




  devise_for :users, :controllers => { registrations: 'users/registrations' }

  resources :users , only: [:create ]

  root to: 'pages#home'

  match 'profil', to: 'users#show', via: 'get'
  mount StripeEvent::Engine, at: '/stripe-webhooks'

  get "/histoire", to: "pages#story"
  get "/tarifs", to: "pages#tarifs"
  get "/about", to: "pages#about"
  post "/simulation", to: "contacts#simulation"



  resources :shopping_carts, only: [:show, :create]

  get '/orders/success'
  get '/orders/cancel'

  resources :orders, only: [:show, :create, :index] do
    resources :payments, only: :new
  end


  resources :services, only: [:index, :show]

  resources :avantages, only: [:index]

  resources :contacts, only: [:new, :create]

  # resources :simulations, only: [:new, :create] do
  #   resources :simulation_orders, only: [:show, :create, :index] do
  #     resources :simulation_payments, only: :new
  #   end
  # end

  resources :courses, only: [:new, :create, :index, :show, :destroy] do
    resources :drops, only: [ :new, :create ]
    resources :pickups, only: [ :new, :create ]

  end

  #course building
  post 'course/distance', to: 'courses#distance'
  post 'course/ticket_urgence', to: 'courses#ticket_urgence'
  get 'course/init_urgences', to: 'courses#init_urgences'
  post 'course/ticket_distance', to: 'courses#ticket_distance'
  post 'course/ticket_volume', to: 'courses#ticket_volume'
  # post 'course/checkout', to: 'courses#checkout_id'

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
