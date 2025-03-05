module AssociationDataDeleter
  class Engine < ::Rails::Engine
    isolate_namespace AssociationDataDeleter
    
    # エンジンのミドルウェアやルーティングなどの設定
    initializer "association_data_deleter.assets" do |app|
      app.config.assets.precompile += %w(association_data_deleter/application.css)
    end
    
    # パスの設定
    paths["app/controllers"] = File.expand_path("../controllers", __FILE__)
    paths["app/views"] = File.expand_path("../views", __FILE__)
    paths["config"] = File.expand_path("../config", __FILE__)
    
    config.autoload_paths += %W(
      #{root}/lib/association_data_deleter/controllers
      #{root}/lib/association_data_deleter/models
    )
    
    config.eager_load_paths += %W(
      #{root}/lib/association_data_deleter/controllers
      #{root}/lib/association_data_deleter/models
    )
  end
end
