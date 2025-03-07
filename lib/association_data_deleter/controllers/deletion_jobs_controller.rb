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
  end
end 
