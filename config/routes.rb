Rails.application.routes.draw do

  root :to => 'circles#index'

  resources :circles , :only => :index

  resources :decisions, :only => [:index, :show, :new, :create]

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  resources :users, :only => [:index, :show, :new, :create]

end
