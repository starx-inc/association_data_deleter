if defined?(Rails)
  module AssociationDataDeleter
    class Railtie < Rails::Railtie
      rake_tasks do
        load File.expand_path('../../tasks/association_data_deleter.rake', __FILE__)
      end
      
      initializer "association_data_deleter.configure_rails_initialization" do
        Rails.application.config.after_initialize do
          Rails.application.routes.append do
            # ホストアプリケーションで以下のようにマウントできるようにする
            # mount AssociationDataDeleter::Engine, at: "/association_data_deleter"
          end
        end
      end
    end
  end
end
