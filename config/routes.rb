Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  get 'rooms/:id/activate', :to => 'rooms#activate'
  get 'rooms/:room_url/questions/:question_id/stats', :to => 'questions#show'
  devise_for :users, controllers: { registrations: "my_devise/registrations" }
  resources :users
  resources :rooms
  resources :questions
  resources :answers
end
