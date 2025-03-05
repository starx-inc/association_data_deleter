module AssociationDataDeleter
  class ApplicationController < ::ApplicationController
    layout 'application'
    
    def self.inherited(subclass)
      super
      subclass.class_eval do
        helper_method :view_paths_for_association_data_deleter
      end
    end
    
    def view_paths_for_association_data_deleter
      gem_path = Gem::Specification.find_by_name('association_data_deleter').gem_dir
      view_path = File.join(gem_path, 'lib', 'association_data_deleter', 'views')
      prepend_view_path(view_path)
    end
    
    def process(action, *args)
      view_paths_for_association_data_deleter
      super
    end
  end
end 
