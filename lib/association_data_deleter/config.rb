module AssociationDataDeleter
  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end
  end

  class Config
    attr_accessor :authenticate,
                  :preparation_job_queue,
                  :preparation_job_definition,
                  :execution_job_queue,
                  :execution_job_definition

    def initialize
      # デフォルトは何もしないProcを設定しておく
      @authenticate = ->(controller) {}

      @preparation_job_queue = 'default-preparation-job-queue'
      @preparation_job_definition = 'default-preparation-job-definition'
      @execution_job_queue = 'default-execution-job-queue'
      @execution_job_definition = 'default-execution-job-definition'
    end
  end
end
