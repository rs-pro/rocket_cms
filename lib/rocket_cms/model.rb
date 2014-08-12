module RocketCMS
  module Model
    extend ActiveSupport::Concern
    included do
      include Mongoid::Document
      include Mongoid::Timestamps::Short
      include ActiveModel::ForbiddenAttributesProtection
      include BooleanField
      include SortField
      include Mongoid::Paperclip
      include SmartExcerpt
      include SimpleCaptcha::ModelHelpers

      if defined?(Trackable)
        include Trackable
      end
    end
  end
end
