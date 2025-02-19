module AssociationDataDeleter
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Installs AssociationDataDeleter by copying migrations files to your application."

      # マイグレーションファイルをホストアプリへコピーするタスク
      def copy_migrations
        say_status("info", "Copying migrations from AssociationDataDeleter...", :blue)
        rake("railties:install:migrations FROM=association_data_deleter")
      end

      # オプションとして、コピー後にマイグレーションを実行するかユーザーに確認する
      def run_migrations
        if yes?("Would you like to run the migrations now? [Y/n]")
          rake("db:migrate")
        else
          say_status("info", "Remember to run `rails db:migrate` later.", :yellow)
        end
      end
    end
  end
end
