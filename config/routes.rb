Enterpriseape::Application.routes.draw do
  resources :companies do 
    collection { post :import }
  end
  
  resources :invoices

  root to: 'welcome#index'
  
end
