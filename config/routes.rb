Enterpriseape::Application.routes.draw do
  get 'search/index'

  resources :companies do 
    collection { post :import }
  end

  root to: 'search#index'
  
end
