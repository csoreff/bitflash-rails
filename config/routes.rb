Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users,
             :controllers => { registrations: "my_devise/registrations"}

  resources :friendships do
    resources :transactions, only: [:new, :create]
  end

  get '/users/:id/account', to: 'accounts#index'
end
