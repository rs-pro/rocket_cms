module RocketCMS
  class Engine < ::Rails::Engine
    rake_tasks do
      require File.expand_path('../tasks', __FILE__)
    end

    initializer 'rocket_cms.paperclip' do
      require 'paperclip/style'
      module ::Paperclip
        class Style
          alias_method :processor_options_without_auto_orient, :processor_options
          def processor_options
            processor_options_without_auto_orient.merge(auto_orient: false)
          end
        end
      end
    end

    config.after_initialize do
      # trigger autoload so models are registered in Mongoid::Elasticearch
      RocketCMS.config.search_models.map(&:constantize)

      # Write default email settings to DB so they can be changed.
      if Settings.table_exists?
        Settings.default_email_from(default: 'noreply@rscx.ru')
        Settings.form_email(default: 'glebtv@ya.ru')
        Settings.email_topic(default: 'с сайта')
      end
    end
  end
end

