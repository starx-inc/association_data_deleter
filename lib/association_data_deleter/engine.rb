module AssociationDataDeleter
  class Engine < ::Rails::Engine
    isolate_namespace AssociationDataDeleter
    
    # テーブル名のプレフィックスを無効化
    initializer "association_data_deleter.set_table_name" do |app|
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.descendants.each do |model|
          if model.name.start_with?('AssociationDataDeleter::')
            model.table_name_prefix = ''
          end
        end
      end
    end
    
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
