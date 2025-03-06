module AssociationDataDeleter
  class Engine < ::Rails::Engine
    # Railsの内部で使われる名前空間
    config.engine_name = "association_data_deleter"
    
    # ビューの検索パスを明示的に設定
    initializer "association_data_deleter.append_views" do |app|
      # GemのPathを取得
      gem_path = Gem::Specification.find_by_name('association_data_deleter').gem_dir
      view_path = File.join(gem_path, 'lib', 'association_data_deleter', 'views')
      
      # ビューパスをアプリケーションに追加
      ActionController::Base.prepend_view_path(view_path)
      
      # アセットパスの追加
      app.config.assets.paths << view_path if app.config.respond_to?(:assets)
    end
    
    # テンプレートのパスを設定
    paths["app/views"] = "lib/association_data_deleter/views"
    
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
