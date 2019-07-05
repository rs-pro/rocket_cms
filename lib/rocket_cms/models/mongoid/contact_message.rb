module RocketCMS
  module Models
    module Mongoid
      module ContactMessage
        extend ActiveSupport::Concern
        included do
          field :name, type: String
          field :email, type: String
          field :phone, type: String
          field :content, type: String
          RocketCMS.config.contacts_fields.each_pair do |fn, ft|
            next if ft.nil?
            field fn, type: ft
          end

          after_create :send_notification!
        end
      end
    end
  end
end

