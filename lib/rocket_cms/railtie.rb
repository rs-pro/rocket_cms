module RocketCMS
  class Railtie < Rails::Railtie
    rake_tasks do
      require File.expand_path('../tasks', __FILE__)
    end

    initializer "rocket_cms.ckeditor" do
      if Object.const_defined?("Ckeditor")
        Ckeditor.setup do |config|
          require "ckeditor/orm/mongoid"
        end
      end
    end

    initializer 'rocket_cms.mongoid-audit' do
      Mongoid::Audit.tracker_class_name = :history_tracker
      Mongoid::Audit.current_user_method = :current_user
      Mongoid::Audit.modifier_class_name = "User"
      require_dependency 'history_tracker.rb' if Rails.env.development?
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
      RocketCMS.configuration.search_models.map(&:constantize)
    end
  end
end
