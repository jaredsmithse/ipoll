Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  get 'rooms/:id/activate', :to => 'rooms#activate'
  get 'answers/:id/choose', to: 'answers#choose'
  get 'rooms/:room_url/questions/:question_id/stats', :to => 'questions#show'
  get 'questions/:id/start', to: 'questions#start'
  get 'questions/:id/stop', to: 'questions#stop'
  devise_for :users, controllers: { registrations: "my_devise/registrations" }
  resources :users
  resources :rooms
  resources :questions
  resources :answers
end
