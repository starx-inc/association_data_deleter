module AssociationDataDeleter
  class DeletionJobDetail < ActiveRecord::Base
    belongs_to :deletion_job
  end
end
