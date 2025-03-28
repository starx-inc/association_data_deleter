# frozen_string_literal: true

require_relative "association_data_deleter/version"

require_relative "association_data_deleter/engine" if defined?(Rails)
require_relative "association_data_deleter/railtie" if defined?(Rails)

require_relative "association_data_deleter/models/deletion_job"
require_relative "association_data_deleter/models/deletion_job_detail"
require_relative "association_data_deleter/aws_batch"
require_relative "association_data_deleter/config"

module AssociationDataDeleter
  class Error < StandardError; end
  # Your code goes here...
end
