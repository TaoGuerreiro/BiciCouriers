 Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  resources :users , only: [:create ]

  root to: 'pages#home'



# SEO__________________

  match "/old_path_to_services/:id", to: redirect("/services/%{id}s"), via: 'get'

#SEO_END_______________

  match 'profil', to: 'users#show', via: 'get'

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  get "/histoire", to: "pages#story"
  get "/covid_19", to: "pages#covid"
  get "/tarifs", to: "pages#tarifs"
  get "/about", to: "pages#about"
  post "/simulation", to: "contacts#simulation"



  # resources :shopping_carts, only: [:show, :create]

  get '/orders/success'
  get '/orders/cancel'

  resources :orders, only: [:show, :create, :index] do
    resources :payments, only: :new
  end


  resources :services, only: [:index, :show]

  resources :avantages, only: [:index]

  resources :contacts, only: [:new, :create]

  resources :deliveries, only: [:new, :create, :index, :show, :destroy] do
    resources :pickups, only: [ :new, :create ]
    resources :drops, only: [ :new, :create ]
  end
  # resources :cities, only: [:current]

  get 'cities/current', to: 'cities#current'

  #course building
  post 'delivery/distance', to: 'deliveries#distance'
  post 'delivery/ticket_urgence', to: 'deliveries#ticket_urgence'
  get 'delivery/init_urgences', to: 'deliveries#init_urgences'
  post 'delivery/ticket_distance', to: 'deliveries#ticket_distance'
  post 'delivery/ticket_volume', to: 'deliveries#ticket_volume'

  resources :favorite_addresses, only: [:new, :create, :index, :show, :destroy]

  resources :tickets_books, only: [:new, :create, :index, :show, :destroy] do
    collection do
      get :inprogress
    end
    collection do
      get :finished
    end
  end

end
