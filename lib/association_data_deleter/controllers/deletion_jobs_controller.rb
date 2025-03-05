module AssociationDataDeleter
  class DeletionJobsController < AssociationDataDeleter::ApplicationController
    def index
      # より直接的な方法でデータを取得
      begin
        # テーブル名を明示的に指定したクエリを使用
        @deletion_jobs = AssociationDataDeleter::DeletionJob.all.order(created_at: :desc)
      rescue ActiveRecord::StatementInvalid => e
        # エラーが発生した場合は接続を使って直接クエリを実行
        connection = ActiveRecord::Base.connection
        @deletion_jobs = connection.exec_query("SELECT * FROM deletion_jobs ORDER BY created_at DESC").map do |row|
          DeletionJob.new(row)
        end
      end
      
      # 明示的にテンプレートを指定
      render template: "deletion_jobs/index", layout: 'application'
    end

    def show
      begin
        @deletion_job = AssociationDataDeleter::DeletionJob.find(params[:id])
        @deletion_job_details = @deletion_job.deletion_job_details
      rescue ActiveRecord::StatementInvalid => e
        # エラーが発生した場合は接続を使って直接クエリを実行
        connection = ActiveRecord::Base.connection
        job_attrs = connection.exec_query("SELECT * FROM deletion_jobs WHERE id = #{params[:id].to_i} LIMIT 1").first
        @deletion_job = DeletionJob.new(job_attrs)
        
        details_attrs = connection.exec_query("SELECT * FROM deletion_job_details WHERE deletion_job_id = #{params[:id].to_i}")
        @deletion_job_details = details_attrs.map { |attrs| DeletionJobDetail.new(attrs) }
      end
      
      # 明示的にテンプレートを指定
      render template: "deletion_jobs/show", layout: 'application'
    end
  end
end 
