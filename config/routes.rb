Enterpriseape::Application.routes.draw do
  devise_for :users
  get 'search/index'
  post 'search/doSearch' => 'search#search'  
  get 'search/doSearch' => 'search#list'
  delete 'search/:numero' => 'search#destroy'

  post 'agreement/make' => 'agreement#make'

  resources :companies do 
    collection { post :import }
  end

  get 'negative_not_valid' => 'agreement#notValidToProccess'
  get 'negative_valid' => 'agreement#validToProccess'

  root to: 'search#index'
  
end
