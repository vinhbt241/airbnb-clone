Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  get "get_user_by_email", to: "home#get_user_by_email"

  namespace :owner do 
    resources :home, only: %i[index]
  end
end
