Rails.application.routes.draw do

  root :to => 'decisions#index'

  resources :circles , except: :show

  resources :decisions, except: :show

  resources :users, except: :show

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'


end
