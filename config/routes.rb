Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  get "authenticate_email", to: "home#authenticate_email"

  namespace :owner do 
    resources :home, only: %i[index]

    resources :properties, only: [] do 
      resources :build_property
    end

    post "start_build_property", to: "home#start_build_property"
  end

  authenticated :user, ->(user) { user.has_role? :admin} do 
    namespace :admin do 
      resources :home, only: %i[index]
    end
  end
end
