module RocketCMS
  class Engine < ::Rails::Engine
    rake_tasks do
      require File.expand_path('../tasks', __FILE__)
    end

    config.after_initialize do
      # trigger autoload so models are registered in Mongoid::Elasticearch
      RocketCMS.config.search_models.map(&:constantize)

      # Write default email settings to DB so they can be changed.
      if defined?(::Settings) && Settings.respond_to?(:table_exists?) && Settings.table_exists?
        Settings.default_email_from(default: 'noreply@rscx.ru')
        Settings.form_email(default: 'glebtv@ya.ru')
        Settings.email_topic(default: 'с сайта')
      end
    end
  end
end

