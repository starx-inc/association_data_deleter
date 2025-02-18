# frozen_string_literal: true

require_relative "association_data_deleter/version"

require_relative "association_data_deleter/railtie" if defined?(Rails)

module AssociationDataDeleter
  class Error < StandardError; end
  # Your code goes here...
end
