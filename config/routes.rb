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
  get '/about_us', to: 'pages#about_us', as: 'about_us'
  get '/faq', to: 'pages#faq', as: 'faq'
  get '/how_it_works', to: 'pages#how_it_works', as: 'how_it_works'
  get '*path' => redirect('/')
end