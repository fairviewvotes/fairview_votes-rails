Rails.application.routes.draw do
  # login link
  get 'sessions/new'

  # google oauth login
  get '/login', to: redirect('/auth/google_oauth2')
  get '/auth/google_oauth2/callback', to: 'sessions#create'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
