# frozen_string_literal: true

require_relative "association_data_deleter/version"

require_relative "association_data_deleter/engine" if defined?(Rails)
require_relative "association_data_deleter/railtie" if defined?(Rails)

require_relative "association_data_deleter/models/deletion_job"
require_relative "association_data_deleter/models/deletion_job_detail"

module AssociationDataDeleter
  class Error < StandardError; end
  # 名前空間接頭辞を空文字列に設定して無効化
  def self.table_name_prefix
    ""
  end

  # Your code goes here...
end
