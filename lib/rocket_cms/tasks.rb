# require this file to load the tasks
require 'rake'

# Require sitemap_generator at runtime. If we don't do this the ActionView helpers are included
# before the Rails environment can be loaded by other Rake tasks, which causes problems
# for those tasks when rendering using ActionView.
namespace :rs do
  # Require sitemap_generator only. When installed as a plugin the require will fail, so in
  # that case, load the environment first.
  task :require do
    Rake::Task['environment'].invoke
  end
  desc "reindex ElasticSearch"
  task :reindex => ['rs:require'] do
    RocketCMS.configuration.search_models.each do |model_name|
      pb = nil
      model_name.constantize.es.index_all do |steps, step|
        pb = ProgressBar.create(title: model_name, total: steps, format: '%t: %p%% %a |%b>%i| %E') if pb.nil?
        pb.increment
      end
    end
  end
end
