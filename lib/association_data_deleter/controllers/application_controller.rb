module AssociationDataDeleter
  class ApplicationController < ::ApplicationController
    layout 'application'

    before_action :set_view_paths

    def view_paths_for_association_data_deleter
      gem_path = Gem::Specification.find_by_name('association_data_deleter').gem_dir
      view_path = File.join(gem_path, 'lib', 'association_data_deleter', 'views')
      prepend_view_path(view_path)
    end
    
    def set_view_paths
      view_paths_for_association_data_deleter
    end
  end
end 
