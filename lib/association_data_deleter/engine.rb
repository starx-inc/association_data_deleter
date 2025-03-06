module AssociationDataDeleter
  class Engine < ::Rails::Engine
    config.engine_name = "association_data_deleter"

    initializer "association_data_deleter.assets.precompile" do |app|
      app.config.assets.precompile += %w( association_data_deleter/application.css )
    end
    
    config.to_prepare do
      Dir.glob(Engine.root.join("lib/association_data_deleter/controllers/**/*.rb")).each do |c|
        require_dependency(c)
      end
    end
  end
end
