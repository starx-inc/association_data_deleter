namespace :association_data_deleter do
  desc "Generate relations YAML by analyzing DB or AR models"
  task :generate_relations_yaml, [:top_table, :output_name] => :environment do |_t, args|
    if args[:top_table].nil? || args[:output_name].nil?
      puts "Please input args [top_table,output_name]."
      exit
    end

    Rails.application.eager_load!

    # リレーションマップ（子テーブル → 親情報）を構築
    puts "[Step 1] Building relation map..."
    relation_map = build_relation_map
    puts "[Step 1] Relation map built. Found #{relation_map.keys.size} child tables."

    # ツリー構造を作成
    puts "[Step 2] Building tree structure..."
    tree_structure = build_tree_structure(relation_map, args[:top_table])
    puts "[Step 2] Tree structure built for root table '#{tree_structure['name']}' with children: #{tree_structure['children'].size}"

    # YAMLフォーマットに変換
    puts "[Step 3] Generating YAML data..."
    yaml_data = build_yaml_data(tree_structure)
    puts "[Step 3] YAML data generation complete."

    # ファイル出力
    output_path = Rails.root.join("config", "deletion_relations_#{args[:output_name]}.yml")
    puts "[Step 4] Writing YAML file to: #{output_path}"
    File.write(output_path, yaml_data)
    puts "[Step 4] YAML file has been successfully generated."
  end
end

# --------------------------------------------------
# 以下はサポートメソッド群
# --------------------------------------------------

def build_relation_map
  relation_map = {}

  # --- 1) belongs_to アソシエーションを子モデル側から辿る ---
  # ↓ ここで ActiveRecord::Base の子孫全てを取得
  ActiveRecord::Base.descendants.each do |model_class|
    # NOTE: 抽象クラスは直接データベースのテーブルと対応していないため対象外
    next if model_class.abstract_class? # 必要？
    # テーブルが実在しない場合はスキップ
    next unless ActiveRecord::Base.connection.data_source_exists?(model_class.table_name)

    model_class.reflect_on_all_associations(:belongs_to).each do |assoc|
      parent_class = assoc.klass rescue nil
      # ActiveRecord::Base 継承ではない or nil の場合はスキップ
      next unless parent_class && parent_class < ActiveRecord::Base
      next if parent_class.abstract_class?

      parent_table = parent_class.table_name
      child_table  = model_class.table_name
      foreign_key  = assoc.foreign_key.to_s  # シンボル→文字列化

      relation_map[child_table] ||= []

      association = {
        parent_table: parent_table,
        foreign_key:  foreign_key
      }

      model_class.superclass.reflect_on_all_associations(:belongs_to).each do |super_assoc|
        if super_assoc.name == assoc.name && super_assoc.options[:polymorphic]
          association[:other_keys] = { super_assoc.foreign_type => parent_class.to_s }
        end
      end

      relation_map[child_table] << association
    end
  end

  # --- 2) 親モデル側の has_one / has_many ( :as => ... ) からpolymorphic関連を拾う ---
  ActiveRecord::Base.descendants.each do |parent_class|
    next if parent_class.abstract_class?
    next unless ActiveRecord::Base.connection.data_source_exists?(parent_class.table_name)

    parent_class.reflect_on_all_associations.select {|a| a.options[:as].present? }.each do |assoc|
      child_class = assoc.klass
      # こちらも ActiveRecord::Base 継承チェック
      next unless child_class && child_class < ActiveRecord::Base
      next if child_class.abstract_class?
      next unless ActiveRecord::Base.connection.data_source_exists?(child_class.table_name)

      child_table  = child_class.table_name
      parent_table = parent_class.table_name
      foreign_key  = assoc.foreign_key.to_s

      relation_map[child_table] ||= []

      association = {
        parent_table: parent_table,
        foreign_key:  foreign_key,
        other_keys:   { "#{assoc.options[:as]}_type" => parent_class.name }
      }

      relation_map[child_table] << association
    end
  end

  relation_map
end

# top_table (companiesなど) を起点に 再帰的にツリー構造を作る
def build_tree_structure(relation_map, top_table)
  {
    "name"      => top_table,
    "id_column" => "id",
    "children"  => child_tables_for(top_table, relation_map, Set.new)
  }
end

def child_tables_for(parent_table, relation_map, visited, bypass = false)
  return [] if visited.include?(parent_table)

  visited.add(parent_table) unless bypass
  bypass = false

  children = []
  relation_map.each do |child_table, parents_info|
    parents_info.each do |pinfo|
      if pinfo[:parent_table] == parent_table && visited.exclude?(child_table)
        child_info = {}
        if pinfo[:other_keys].present?
          child_info["other_keys"] = pinfo[:other_keys]
          bypass = true
        end

        child_info.merge!({
          "name"        => child_table,
          "foreign_key" => pinfo[:foreign_key],
          "children"    => child_tables_for(child_table, relation_map, visited, bypass)
        })
        children << child_info
      end
    end
  end

  children
end

def build_yaml_data(tree)
  appeared = Set.new
  top_table = {
    "name"      => tree["name"],
    "id_column" => tree["id_column"]
  }

  {
    "tables"    => flatten_children(tree["children"], appeared),
    "top_table" => top_table
  }.to_yaml
end

def flatten_children(children, appeared)
  children.map do |child|
    dup_value = child_duplication_judgement_value(child)
    next if appeared.include?(dup_value)
    h = {
      "name"        => child["name"],
      "foreign_key" => child["foreign_key"]
    }
    if child["other_keys"].present?
      h["other_keys"] = child["other_keys"]
    end
    appeared << dup_value
    if child["children"].present? && child["children"].any?
      flat_children = flatten_children(child["children"], appeared)
      h["children"] = flat_children if flat_children.present?
    end
    h
  end.compact
end

def child_duplication_judgement_value(child)
  child_values = [child["name"], child["foreign_key"]]
  if child["other_keys"].present?
    child_values.push(child["other_keys"].keys.join(','), child["other_keys"].values.join(','))
  end
  child_values.join(',')
end
