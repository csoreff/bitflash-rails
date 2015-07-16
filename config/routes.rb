Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users,
             :controllers => { registrations: "my_devise/registrations"}

  resources :friendships do
    resources :transactions, only: [:new, :create]
  end

  resources :addresses, only: [:index, :create]

  get '/users/:id/account', to: 'accounts#index'
end
