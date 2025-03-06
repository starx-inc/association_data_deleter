# frozen_string_literal: true

require_relative "association_data_deleter/version"

require_relative "association_data_deleter/engine" if defined?(Rails)
require_relative "association_data_deleter/railtie" if defined?(Rails)

require_relative "association_data_deleter/models/deletion_job"
require_relative "association_data_deleter/models/deletion_job_detail"

module AssociationDataDeleter
  class Error < StandardError; end
  
  # 名前空間のテーブル名プレフィックスを無効化
  if defined?(ActiveRecord)
    ActiveRecord::Base.class_eval do
      self.table_name_prefix = '' if self.name && self.name.start_with?('AssociationDataDeleter::')
    end
  end
end
