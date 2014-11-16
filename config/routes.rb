Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: "my_devise/registrations" }
  resources :users
  resources :rooms
  resources :questions
  resources :answers
  get 'stats/:room/:question', :to => 'questions#show'
end
