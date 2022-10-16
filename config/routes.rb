Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "home#index"

  get "authenticate_email", to: "home#authenticate_email"

  resources :properties, only: %i[show]

  namespace :owner do 
    resources :home, only: %i[index]

    resources :properties do 
      resources :build_property

      resources :reservations, only: %i[index]
    end

    get "start_build_property", to: "home#start_build_property"
    
    resources :listings, only: %i[index]

    resources :reservations, only: %i[update]
  end

  authenticated :user, ->(user) { user.has_role? :admin} do 
    namespace :admin do 
      resources :home, only: %i[index]
      resources :properties, only: %i[index edit update]
      resources :reservations, only: %i[show]
    end
  end

  resources :reservations, only: %i[index show new create]

  get "reservation/success", to: "reservations#success"

  resources :profile, only: %i[edit update]

  resources :reviews, only: %i[create]
end
