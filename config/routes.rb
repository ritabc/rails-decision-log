Rails.application.routes.draw do

  root :to => 'decisions#index'

  resources :circles , :only => :index

  resources :decisions, except: :show

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  resources :users, :only => [:index, :show, :new, :create]

end
