module AssociationDataDeleter
  class DeletionJob < ActiveRecord::Base
    has_many :deletion_job_details, dependent: :destroy
    
    def self.exists_for_target?(target_id, target_type)
      exists?(target_id: target_id, target_type: target_type)
    end
  end
end
