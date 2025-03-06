module AssociationDataDeleter
  class DeletionJobsController < AssociationDataDeleter::ApplicationController
    def index
      @deletion_jobs = AssociationDataDeleter::DeletionJob.all.order(created_at: :desc)

      render template: "deletion_jobs/index", layout: 'application'
    end
  end
end 
