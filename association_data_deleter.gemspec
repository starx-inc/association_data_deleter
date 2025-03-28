require_relative 'lib/association_data_deleter/version'

Gem::Specification.new do |spec|
  spec.name          = "association_data_deleter"
  spec.author        = "Kanata Hiraguchi"
  spec.version       = AssociationDataDeleter::VERSION
  spec.summary       = "Delete data in child->parent for canceled companies or brands"
  spec.files         = Dir["lib/**/*", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 5.1"
  spec.add_dependency "aws-sdk-batch"
end
