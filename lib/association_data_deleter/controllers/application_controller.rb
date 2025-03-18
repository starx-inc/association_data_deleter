module AssociationDataDeleter
  class ApplicationController < ::ApplicationController
    layout 'application'

    before_action :authenticate_host_app!
    before_action :set_view_paths

    def set_view_paths
      gem_path = Gem::Specification.find_by_name('association_data_deleter').gem_dir
      view_path = File.join(gem_path, 'lib', 'association_data_deleter', 'views')
      prepend_view_path(view_path)
    end

    private

    def authenticate_host_app!
      # ホストアプリから渡された認証Procを実行する
      AssociationDataDeleter.config.authenticate.call(self)
    end
  end
end 
