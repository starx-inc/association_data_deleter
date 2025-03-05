module AssociationDataDeleter
  class DeletionJobDetail < ActiveRecord::Base
    self.table_name = "deletion_job_details"
    
    belongs_to :deletion_job, 
               class_name: "AssociationDataDeleter::DeletionJob"
  end
end
