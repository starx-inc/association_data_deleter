module AssociationDataDeleter
  class Engine < ::Rails::Engine
    config.engine_name = "association_data_deleter"
    
    config.to_prepare do
      Dir.glob(Engine.root.join("lib/association_data_deleter/controllers/**/*.rb")).each do |c|
        require_dependency(c)
      end
    end
  end
end
