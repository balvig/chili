Dummy::Application.routes.draw do
  resources :users, :posts
  resource :session
  root to: 'posts#index'
end
