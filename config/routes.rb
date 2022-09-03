Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  namespace :owner do 
    resources :home, only: %i[index]
  end
end
