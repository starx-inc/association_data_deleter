module AssociationDataDeleter
  class Engine < ::Rails::Engine
    isolate_namespace AssociationDataDeleter
    
    initializer "association_data_deleter.assets.precompile" do |app|
      app.config.assets.precompile += %w( association_data_deleter/application.css )
    end
    
    initializer "association_data_deleter.set_table_names" do |app|
      ActiveSupport.on_load(:active_record) do
        AssociationDataDeleter::DeletionJob.table_name = "deletion_jobs"
        AssociationDataDeleter::DeletionJobDetail.table_name = "deletion_job_details"
      end
    end
    
    config.to_prepare do
      Dir.glob(Engine.root.join("lib/association_data_deleter/controllers/**/*.rb")).each do |c|
        require_dependency(c)
      end
      
      Dir.glob(Engine.root.join("lib/association_data_deleter/models/**/*.rb")).each do |m|
        require_dependency(m)
      end
    end
  end
end
