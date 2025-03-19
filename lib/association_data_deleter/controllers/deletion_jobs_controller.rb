module AssociationDataDeleter
  class DeletionJobsController < AssociationDataDeleter::ApplicationController
    def index
      @deletion_jobs = AssociationDataDeleter::DeletionJob.all.order(created_at: :desc)

      render template: "deletion_jobs/index", layout: 'application'
    end

    def show
      @deletion_job = AssociationDataDeleter::DeletionJob.find(params[:id])
      @deletion_job_details = @deletion_job.deletion_job_details

      render template: "deletion_jobs/show", layout: 'application'
    end

    def create
      @deletion_job = AssociationDataDeleter::DeletionJob.new(
        target_id: params[:target_id],
        target_type: params[:target_type],
        status: 'preparing'
      )
      @deletion_job.save!

      batch = AssociationDataDeleter::AwsBatch.new
      aws_batch_job_id = batch.submit_preparation_job("preparation_for_job_id_#{@deletion_job.id}", @deletion_job.id.to_s)
      @deletion_job.update(prepare_aws_batch_job_id: aws_batch_job_id)

      redirect_to association_data_deleter_engine.deletion_jobs_path
    end
  end
end 
