module AssociationDataDeleter
  class Engine < ::Rails::Engine
    # 名前空間を分離するが、テーブル名プレフィックスは使わない設定
    # 通常のisolate_namespaceの代わりに、必要な設定のみを手動で行う
    
    # Railsの内部で使われる名前空間
    config.engine_name = "association_data_deleter"
    
    # ビューの名前空間
    paths["app/views"] = "lib/association_data_deleter/views"
    
    # ヘルパーの名前空間
    ActiveSupport.on_load(:action_controller) do
      helper AssociationDataDeleter::Engine.helpers
    end
    
    # テーブル名プレフィックスを明示的に空に設定
    initializer "association_data_deleter.set_table_name_prefix", before: :load_config_initializers do
      ActiveRecord::Base.table_name_prefix = '' if defined?(ActiveRecord)
      
      # 念のため個別モデルにも設定
      config.to_prepare do
        AssociationDataDeleter::DeletionJob.table_name = "deletion_jobs" if defined?(AssociationDataDeleter::DeletionJob)
        AssociationDataDeleter::DeletionJobDetail.table_name = "deletion_job_details" if defined?(AssociationDataDeleter::DeletionJobDetail)
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
