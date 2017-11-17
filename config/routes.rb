Enterpriseape::Application.routes.draw do
  get 'search/index'
  post 'search/doSearch' => 'search#search'

  resources :companies do 
    collection { post :import }
  end

  root to: 'search#index'
  
end
