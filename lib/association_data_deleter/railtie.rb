if defined?(Rails)
  module AssociationDataDeleter
    class Railtie < Rails::Railtie
      rake_tasks do
        load File.expand_path('../../tasks/association_data_deleter.rake', __FILE__)
      end
    end
  end
end
