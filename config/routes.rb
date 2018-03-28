Rails.application.routes.draw do
  # Registration
  get 'registration/new'
  get 'registration/good'
  post 'registration/check'

  ## login
  get 'sessions/new'
  delete '/logout',  to: 'sessions#destroy'

  # google oauth login
  get '/login', to: redirect('/auth/google_oauth2')
  get '/auth/google_oauth2/callback', to: 'sessions#create'

  resources :users
end
