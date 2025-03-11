require 'aws-sdk-batch'

module AssociationDataDeleter
  class AwsBatch
    def initialize
      @client = Aws::Batch::Client.new(region: 'ap-northeast-1')
    end

    def submit_preparation_job(job_name, deletion_job_id)
      response = @client.submit_job({
        job_name: job_name,
        job_queue: AssociationDataDeleter.config.preparation_job_queue,
        job_definition: AssociationDataDeleter.config.preparation_job_definition,
        parameters: {
          'deletion_job_id' => deletion_job_id
        }
      })
      response.job_id
    end
  end
end
