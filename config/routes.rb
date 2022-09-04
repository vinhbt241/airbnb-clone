Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  get "authenticate_email", to: "home#authenticate_email"

  namespace :owner do 
    resources :home, only: %i[index]
  end

  authenticated :user, ->(user) { user.has_role? :admin} do 
    namespace :admin do 
      resources :home, only: %i[index]
    end
  end
end
