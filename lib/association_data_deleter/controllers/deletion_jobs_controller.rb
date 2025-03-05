module AssociationDataDeleter
  class DeletionJobsController < AssociationDataDeleter::ApplicationController
    layout "association_data_deleter/application"
    
    # デフォルトのindex挙動をオーバーライドして、DeletionJobとその詳細を取得
    def index
      # インデックスページのロジック
      @title = "データ削除ジョブ管理"
      # @deletion_jobs = ... モデル取得など
    end

    # ジョブの詳細を表示
    def show
      @id = params[:id]
      @title = "ジョブID: #{@id}の詳細"
      # @deletion_job = ... モデル取得など
    end
  end
end 
