Rails.application.routes.draw do
  root 'homes#index'
  get '/account', to: 'accounts#index'

  devise_for :users,
             :controllers => { registrations: "my_devise/registrations"}

  resources :friendships, only: [:create, :destroy] do
    resources :transactions, only: [:new, :create]
  end
  resources :transactions, only: [:index]
  resources :btcaddresses, only: [:index, :create]
end
