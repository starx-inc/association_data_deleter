module AssociationDataDeleter
  class Engine < ::Rails::Engine
    isolate_namespace AssociationDataDeleter
    
    # コントローラーとビューのパス設定
    config.paths["app/controllers"] = File.expand_path("../controllers", __FILE__)
    config.paths["app/views"] = File.expand_path("../views", __FILE__)
    
    # アセットの設定
    initializer "association_data_deleter.assets" do |app|
      app.config.assets.precompile += %w( association_data_deleter/application.css association_data_deleter/application.js )
    end
    
    # コントローラーを直接ロードできるようにする設定
    config.autoload_paths += %W(
      #{config.root}/lib
      #{config.root}/lib/association_data_deleter
      #{config.root}/lib/association_data_deleter/controllers
    )
    
    # Eager Loading設定
    config.eager_load_paths += %W(
      #{config.root}/lib
      #{config.root}/lib/association_data_deleter
      #{config.root}/lib/association_data_deleter/controllers
    )

    # コントローラーが正しく読み込まれるようにする
    initializer "association_data_deleter.controllers" do
      ActiveSupport.on_load(:action_controller) do
        require_dependency File.expand_path("../controllers/application_controller", __FILE__)
        require_dependency File.expand_path("../controllers/deletion_jobs_controller", __FILE__)
      end
    end
  end
end
