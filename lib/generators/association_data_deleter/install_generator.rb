module AssociationDataDeleter
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include ::Rails::Generators::Migration

      desc "Installs AssociationDataDeleter by copying migrations files to your application."

      source_root File.expand_path('templates', __dir__)

      # マイグレーションファイルをホストアプリへコピーするタスク
      def copy_migrations
        say_status("info", "Copying migrations from AssociationDataDeleter...", :blue)
        migration_template "create_deletion_jobs.rb", "db/migrate/create_deletion_jobs.rb"
      end

      # オプションとして、コピー後にマイグレーションを実行するかユーザーに確認する
      def run_migrations
        if yes?("Would you like to run the migrations now? [Y/n]")
          rake("db:migrate")
        else
          say_status("info", "Remember to run `rails db:migrate` later.", :yellow)
        end
      end

      def self.next_migration_number(_dirname)
        sleep 1
        Time.new.utc.strftime('%Y%m%d%H%M%S')
      end
    end
  end
end
