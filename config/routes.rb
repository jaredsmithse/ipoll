Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: "my_devise/registrations" }
  resources :users
  resources :rooms
end
