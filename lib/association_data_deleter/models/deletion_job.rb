module AssociationDataDeleter
  class DeletionJob < ActiveRecord::Base
    self.table_name = "deletion_jobs"
    
    has_many :deletion_job_details, 
             class_name: "AssociationDataDeleter::DeletionJobDetail",
             dependent: :destroy
  end
end
