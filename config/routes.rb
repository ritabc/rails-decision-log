Rails.application.routes.draw do

  root :to => 'decisions#unincorporated'

  resources :circles , :only => :index

  resources :decisions, :only => :index

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  
end
