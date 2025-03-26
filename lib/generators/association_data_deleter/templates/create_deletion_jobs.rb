class CreateDeletionJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :deletion_jobs, id: :bigint do |t|
      t.string :target_id, null: false, comment: "削除対象レコードID (例: brand.id, company.id)"
      t.string :target_type, null: false, comment: "削除対象テーブル種別 (例: 'Brand', 'Company', 'ShopCompany')"
      t.string :status, null: false, comment: "ジョブ状態: preparing / ready / in_progress / completed / failed"
      t.string :prepare_aws_batch_job_id, comment: "準備フェーズ(AWS Batch)のジョブID"
      t.string :delete_aws_batch_job_id, comment: "実削除フェーズ(AWS Batch)のジョブID"
      t.datetime :prepare_started_at, comment: "準備フェーズ開始時刻"
      t.datetime :prepare_finished_at, comment: "準備フェーズ完了または失敗時刻"
      t.datetime :delete_started_at, comment: "実データ削除開始時刻"
      t.datetime :delete_finished_at, comment: "実データ削除完了または失敗時刻"
      t.integer  :deleted_count, comment: "ジョブ全体で削除されたレコード数"
      t.integer  :target_count, comment: "ジョブ全体の削除対象件数"
      t.text :error_message, comment: "エラー時のメッセージ"

      t.timestamps
    end

    add_index :deletion_jobs, [:target_type, :target_id], unique: true

    create_table :deletion_job_details, id: :bigint do |t|
      t.references :deletion_job, null: false, type: :bigint, foreign_key: true, comment: "親 deletion_jobs.id"
      t.string :table_name, null: false, comment: "削除対象テーブル名"
      t.string :foreign_key, comment: "外部キー"
      t.string :polymorphic_id, comment: "ポリモーフィックのID（必要に応じて）"
      t.string :polymorphic_type, comment: "ポリモーフィックのクラス名"
      t.string :status, null: false, comment: "テーブル単位状態: pending, in_progress, completed, failed"
      t.integer :deleted_count, comment: "テーブル毎の削除件数"
      t.integer :target_count, comment: "テーブル毎の削除対象件数"
      t.string :last_deleted_id, comment: "チャンク削除の進捗管理用 (必要なら利用)"
      t.text :error_message, comment: "テーブル単位のエラー情報"
      t.datetime :started_at, comment: "テーブル削除開始時刻"
      t.datetime :finished_at, comment: "テーブル削除完了 or 失敗時刻"

      t.timestamps
    end
  end
end
