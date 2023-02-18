Rails.application.routes.draw do
  root 'dashboard#index'
  
  get '/n1', to: 'n1#index'
  get '/not_n1', to: 'not_n1#index'

  resources :organizations do
    resources :branches, except: %i[new show]
  end
end
