AssociationDataDeleter::Engine.routes.draw do
  # 名前空間を明示的に指定してルーティングを設定
  scope module: 'association_data_deleter' do
    resources :deletion_jobs, only: %i(index show create destroy) do
      post :execute, on: :member
    end
  end
end 
