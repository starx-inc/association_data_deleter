module AssociationDataDeleter
  class DeletionJobsController < ApplicationController
    layout 'association_data_deleter/application'
    
    # デフォルトのindex挙動をオーバーライドして、DeletionJobとその詳細を取得
    def index
      # 必要なロジックを記述
      # 例: @deletion_jobs = モデル取得など
    end

    # ジョブの詳細を表示
    def show
      @id = params[:id]
      # 必要なロジックを記述
      # 例: @deletion_job = モデル.find(params[:id])など
    end
  end
end 
