Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  get "authenticate_email", to: "home#authenticate_email"

  namespace :owner do 
    resources :home, only: %i[index]
  end
end
