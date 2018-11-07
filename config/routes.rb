Rails.application.routes.draw do
  root 'pages#landing'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, :controllers => { :registrations => :registrations }


  resources :listings do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index, :destroy] do
    resource :review, except: [:show]
  end

  get '/:user_id/profile', to: 'pages#profile', as: 'profile'
end