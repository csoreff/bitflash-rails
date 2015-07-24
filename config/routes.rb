Rails.application.routes.draw do
  root 'homes#index'
  get '/account', to: 'accounts#index'
  get '/account/withdraw', to: 'accounts#new'
  post '/account/withdraw', to: 'accounts#create'

  devise_for :users,
             :controllers => { registrations: "my_devise/registrations"}

  resources :friendships, only: [:index, :create, :destroy] do
    resources :transactions, only: [:new, :create]
  end

  resources :transactions, only: [:index]
  resources :btcaddresses, only: [:index, :create]
end
