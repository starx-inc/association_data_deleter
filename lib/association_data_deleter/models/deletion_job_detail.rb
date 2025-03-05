module AssociationDataDeleter
  class DeletionJobDetail < ActiveRecord::Base
    # テーブル名を明示的に指定（クラスメソッドとして定義して強制）
    def self.table_name
      "deletion_job_details"
    end
    
    belongs_to :deletion_job, 
               class_name: "AssociationDataDeleter::DeletionJob"
  end
end
