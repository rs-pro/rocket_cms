module RailsAdmin
  module Config
    module Fields
      module Types
        class Menu < RailsAdmin::Config::Fields::Base
          # Register field type for the type loader
          RailsAdmin::Config::Fields::Types::register(self)
          include RailsAdmin::Engine.routes.url_helpers

          register_instance_option :pretty_value do
            obj = bindings[:object]
            ret = RocketCMS::Menu.build_toggles(bindings[:view], @abstract_model, obj, 'sm', 'margin-bottom: 5px;')
            ('<div style="white-space: normal;">' + ret.join(' ') + '</div>').html_safe
          end

          register_instance_option :formatted_value do
            pretty_value
          end

          register_instance_option :export_value do
            nil
          end

          register_instance_option :partial do
            :form_raw
          end
        end
      end
    end
  end
end

module RailsAdmin
  module Config
    module Actions
      class ToggleMenu < Base
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          false
        end

        # Is the action on an object scope (Example: /admin/team/1/edit)
        register_instance_option :member? do
          true
        end

        register_instance_option :controller do
          proc do
            ajax_link = Proc.new do |am, obj, menu, on|
              render json: {
                href: toggle_menu_path(model_name: am, id: obj.id, menu: menu.id, on: !on),
                class: on ? "btn-success" : "btn-danger",
              }
            end
            if params['id'].present?
              begin
                @object = @abstract_model.model.find(params['id'])
                @menu = ::Menu.find(params[:menu])
                if params[:on] == 'true'
                  @object.menus << @menu
                else
                  @object.menus.delete(@menu)
                end

                if @object.save
                  if params['ajax'].present?
                    if params[:on] == 'true'
                      ajax_link.call(@abstract_model, @object, @menu, true)
                    else
                      ajax_link.call(@abstract_model, @object, @menu, false)
                    end
                  else
                    if params[:on] == 'true'
                      flash[:success] = I18n.t('rs.m.enabled', menu: @menu.name)
                    else
                      flash[:success] = I18n.t('rs.m.disabled', menu: @menu.name)
                    end
                  end
                else
                  if params['ajax'].present?
                    render text: @object.errors.full_messages.join(', '), layout: false, status: 422
                  else
                    flash[:error] = @object.errors.full_messages.join(', ')
                  end
                end
              rescue Exception => e
                if params['ajax'].present?
                  render text: I18n.t('rs.m.error', err: e.to_s), status: 422
                else
                  flash[:error] = I18n.t('rs.m.error', err: e.to_s)
                end
              end
            else
              if params['ajax'].present?
                render text: I18n.t('rs.m.no_id'), status: 422
              else
                flash[:error] = I18n.t('rs.m.no_id')
              end
              
            end
            
            redirect_to :back unless params['ajax'].present?
          end
        end

        register_instance_option :link_icon do
          'icon-move'
        end

        register_instance_option :http_methods do
          [:post]
        end
      end
    end
  end
end
