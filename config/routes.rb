Enterpriseape::Application.routes.draw do
  get 'search/index'

  resources :companies do 
    collection { post :import }
  end

  root to: 'search#index'
  match '/request' => 'search#create', via: :post
  match '/request' => 'search#create', via: :get
  
end
