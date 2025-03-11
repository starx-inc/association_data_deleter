require 'aws-sdk-batch'

module AssociationDataDeleter
  class AwsBatch
    def initialize
      @client = Aws::Batch::Client.new(region: 'ap-northeast-1')
    end
  end
end
