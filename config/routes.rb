Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  get "authenticate_email", to: "home#authenticate_email"

  resources :property, only: %i[show]

  namespace :owner do 
    resources :home, only: %i[index]

    resources :properties, only: [] do 
      resources :build_property
    end

    get "start_build_property", to: "home#start_build_property"
    
    resources :listings, only: %i[index]
  end

  authenticated :user, ->(user) { user.has_role? :admin} do 
    namespace :admin do 
      resources :home, only: %i[index]

      get "show_properties", to: "home#show_properties"
      get "show_reservations", to: "home#show_reservations"
    end
  end

  resources :reservations, only: %i[index new create]
end
