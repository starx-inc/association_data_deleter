require_relative 'lib/association_data_deleter/version'

Gem::Specification.new do |spec|
  spec.name          = "association_data_deleter"
  spec.author        = "Kanata Hiraguchi"
  spec.version       = AssociationDataDeleter::VERSION
  spec.summary       = "Delete data in child->parent for canceled companies or brands"
  spec.files         = Dir["lib/**/*", "db/**/*", "README.md"]
  spec.require_paths = ["lib"]

  # Rails/ActiveRecordを使う場合
  spec.add_dependency "rails", ">= 5.1", "< 8.0"
  # など、必要に応じて依存ライブラリを追記
end
