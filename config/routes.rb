Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users,
             :controllers => { registrations: "my_devise/registrations"}
  resources :friendships
end
