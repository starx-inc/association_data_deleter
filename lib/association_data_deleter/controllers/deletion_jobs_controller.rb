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
        target_type: params[:target_type]
      )
      @deletion_job.save!

      redirect_to @deletion_job
    end
  end
end 
