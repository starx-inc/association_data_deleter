module AssociationDataDeleter
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    # 開発環境でのみ利用可能にするオプション
    before_action :check_development_only, if: -> { AssociationDataDeleter.config.development_only }
    
    private
    
    def check_development_only
      unless Rails.env.development?
        flash[:alert] = "この機能は開発環境でのみ利用可能です。"
        redirect_to main_app.root_path
      end
    end
  end
end 
