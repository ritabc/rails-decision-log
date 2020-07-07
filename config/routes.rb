Rails.application.routes.draw do

  root :to => 'decisions#all'

  get '/all', to: 'decisions#all'

  resources :circles , except: :show do
    get '/decisions', to: 'circle_decisions#index'
  end

  get '/review', to: 'decisions#review'

  resources :decisions, except: [:show, :index]

  resources :users

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  resources :password_resets, except: [:show, :index, :destroy]

end
