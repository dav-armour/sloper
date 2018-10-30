Rails.application.routes.draw do
  resources :listings
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  get '/:user_id/profile', to: 'pages#profile', as: 'profile'
  root 'pages#landing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end