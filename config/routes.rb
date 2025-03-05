AssociationDataDeleter::Engine.routes.draw do
  resources :deletion_jobs, only: %i(index show)
end 
