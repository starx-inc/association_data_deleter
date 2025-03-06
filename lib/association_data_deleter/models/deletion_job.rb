module AssociationDataDeleter
  class DeletionJob < ActiveRecord::Base
    # テーブル名を明示的に指定（クラスメソッドとして定義して強制）
    def self.table_name
      "deletion_jobs"
    end
    
    has_many :deletion_job_details, 
             class_name: "AssociationDataDeleter::DeletionJobDetail",
             dependent: :destroy
  end
end
