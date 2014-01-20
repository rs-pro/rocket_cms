# require this file to load the tasks
require 'rake'

# Require sitemap_generator at runtime. If we don't do this the ActionView helpers are included
# before the Rails environment can be loaded by other Rake tasks, which causes problems
# for those tasks when rendering using ActionView.
namespace :rocket_cms do
  # Require sitemap_generator only. When installed as a plugin the require will fail, so in
  # that case, load the environment first.
  task :require do
    Rake::Task['environment'].invoke
  end
end
