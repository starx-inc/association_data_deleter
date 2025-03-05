AssociationDataDeleter::Engine.routes.draw do
  resources :deletion_jobs, only: [:index, :show]
  root to: 'deletion_jobs#index'
end 
