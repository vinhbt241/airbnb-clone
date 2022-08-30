Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  namespace :host do 
    resources :home
  end
end
