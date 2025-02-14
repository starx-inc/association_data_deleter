namespace :association_data_deleter do
  desc "Generate relations YAML by analyzing DB or AR models"
  task :generate_relations_yaml, [:top_table, :output_name] => :environment do |_t, args|
    # 1) 引数を取得
    top_table   = args[:top_table]
    output_name = args[:output_name] || "deletion_relations"

    # 2) YAMLに書き込むデータ（仮例：単純に固定値）
    relations_data = {
      "tables" => [
        {
          "name"        => "orders",
          "foreign_key" => "company_id",
          "children"    => [
            { "name" => "order_items", "foreign_key" => "order_id" }
          ]
        }
      ],
      "top_table" => {
        "name"      => top_table || "companies",
        "id_column" => "id"
      }
    }

    # 3) 出力ファイルを決定
    file_path = "config/deletion_relations_#{output_name}.yml"

    # 4) ファイルに書き込む
    File.open(file_path, "w") do |f|
      f.write(relations_data.to_yaml)
    end

    puts "Generated YAML: #{file_path}"
  end
end
