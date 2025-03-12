# AssociationDataDeleter

## Installation

Add `deletion_jobs`, `deletion_job_details` tables to your database:

```bash
bundle exec rails generate association_data_deleter:install
bundle exec rails db:migrate
```

## Usage

Create association data YAML file.
```bash
bundle exec rake association_data_deleter:generate_relations_yaml[top_table_name,product_name]
```

Set AWS Batch job queue and task definition.
```ruby
# config/initializers/association_data_deleter.rb

AssociationDataDeleter.configure do |config|
  config.preparation_job_queue = 'sample-preparation-job-queue'
  config.preparation_job_definition = 'sample-preparation-job-definition'
  config.execution_job_queue = 'sample-execution-job-queue'
  config.execution_job_definition = 'sample-execution-job-definition'
end
```
