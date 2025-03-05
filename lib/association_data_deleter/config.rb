module AssociationDataDeleter
  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end
  end

  class Config
    attr_accessor :development_only

    def initialize
      @development_only = true # デフォルトでは開発環境のみ有効
    end
  end
end 
