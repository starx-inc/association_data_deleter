# frozen_string_literal: true

require_relative "association_data_deleter/version"
require_relative "association_data_deleter/config"

require_relative "association_data_deleter/engine" if defined?(Rails)
require_relative "association_data_deleter/railtie" if defined?(Rails)

require_relative "association_data_deleter/models/deletion_job"
require_relative "association_data_deleter/models/deletion_job_detail"

module AssociationDataDeleter
  class Error < StandardError; end
  # Your code goes here...
end
