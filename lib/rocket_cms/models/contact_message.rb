module RocketCMS
  module Models
    module ContactMessage
      extend ActiveSupport::Concern
      include RocketCMS::Model
      include RocketCMS.orm_specific('ContactMessage')

      included do
        apply_simple_captcha if respond_to?(:apply_simple_captcha)
        validates_email_format_of :email, unless: -> { email.blank? }
        if RocketCMS.config.contacts_message_required
          validates_presence_of :content
        end
        validate do
          if email.blank? && phone.blank?
            errors.add(:email, I18n.t('rs.no_contact_info'))
          end
        end
      end

      def send_notification!
        ContactMailer.new_message_email(self).deliver
      end
    end
  end
end
