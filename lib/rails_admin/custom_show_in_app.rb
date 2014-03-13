module RailsAdmin
  module Config
    module Actions
      class CustomShowInApp < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

        register_instance_option :visible? do
          authorized? && (bindings[:controller].main_app.url_for(bindings[:object]) rescue false)
        end

        register_instance_option :controller do
          Proc.new do
            if @object.class.name == 'Page'
              redirect_to main_app.page_url(@object)
            else
              redirect_to main_app.url_for(@object)
            end
          end
        end

        register_instance_option :link_icon do
          'fa fa-eye'
        end

        register_instance_option :pjax? do
          false
        end
      end
    end
  end
end
