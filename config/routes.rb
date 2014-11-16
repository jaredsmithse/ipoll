Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: "my_devise/registrations" }
  resources :users
  resources :rooms
  resources :questions
  resources :answers
  get 'rooms/:room_url/questions/:question_id/stats', :to => 'questions#show'
  get 'rooms/:id/activate', :to => 'rooms#activate'
end
