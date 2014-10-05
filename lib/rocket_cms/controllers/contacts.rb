module RocketCMS
  module Controllers
    module Contacts
      extend ActiveSupport::Concern
      def new
        @contact_message = model.new
        after_initialize
      end

      def create
        @contact_message = model.new(message_params)
        after_initialize
        if RocketCMS.configuration.contacts_captcha
          meth = :save_with_captcha
        else
          meth = :save
        end
        if @contact_message.send(meth)
          after_create
          if request.xhr? && process_ajax
            ajax_success
          else
            redirect_after_done
          end
        else
          render_error
        end
      end

      def sent
      end

      private
      def render_error
        if request.xhr? && process_ajax
          render json: @contact_message.errors, status: 422
        else
          flash.now[:alert] = @contact_message.errors.full_messages.join("\n")
          render action: "new", status: 422
        end
      end
      def process_ajax
        true
      end
      def ajax_success
        render json: {ok: true}
      end
      def redirect_after_done
        redirect_to :contacts_sent
      end
      def after_initialize
        # overrideable hook for updating message
      end
      def after_create
        # overrideable hook for updating message
      end
      def model
        ContactMessage
      end
      def message_params
        params.require(:contact_message).permit(RocketCMS.configuration.contacts_fields.keys + [:name, :email, :phone, :content, :captcha, :captcha_key])
      end
    end
  end
end
