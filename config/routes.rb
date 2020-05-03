 Rails.application.routes.draw do
  devise_for :users
  resources :user_facturations, only: [:edit]


  match 'profil', to: 'users#show', via: 'get'

  root to: 'pages#home'
  get "/histoire", to: "pages#story"
  get "/tarifs", to: "pages#tarifs"

  resources :services, only: [:index, :show]

  resources :avantages, only: [:index]

  resources :contacts, only: [:new, :create]

  resources :courses, only: [:new, :create, :index, :show] do
    resources :drops, only: [ :new, :create ]
    resources :pickups, only: [ :new, :create ]
  end

  resources :favorite_addresses, only: [:new, :create, :index, :show, :destroy]

  resources :carnets, only: [:new, :create, :index, :show] do
    collection do
      get :inprogress
    end
    collection do
      get :finished
    end
  end

end
