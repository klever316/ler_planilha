Enterpriseape::Application.routes.draw do
  get 'search/index'
  post 'search/doSearch' => 'search#search'  
  get 'search/doSearch' => 'search#list'
  delete 'search/doSearch' => 'search#destroy'

  resources :companies do 
    collection { post :import }
  end

  get 'negative_not_valid' => 'negative#notValidToProccess'

  root to: 'search#index'
  
end
