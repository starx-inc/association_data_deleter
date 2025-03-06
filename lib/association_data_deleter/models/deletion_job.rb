module AssociationDataDeleter
  class DeletionJob < ActiveRecord::Base
    has_many :deletion_job_details, dependent: :destroy
  end
end
