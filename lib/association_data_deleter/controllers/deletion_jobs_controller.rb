module AssociationDataDeleter
  class DeletionJobsController < ApplicationController
    layout 'association_data_deleter/application'
    
    # デフォルトのindex挙動をオーバーライドして、DeletionJobとその詳細を取得
    def index
      @deletion_jobs = AssociationDataDeleter::DeletionJob.all.order(created_at: :desc)
    end

    # ジョブの詳細を表示
    def show
      @deletion_job = AssociationDataDeleter::DeletionJob.find(params[:id])
      @deletion_job_details = @deletion_job.deletion_job_details.order(created_at: :desc)
    end
  end
end 
