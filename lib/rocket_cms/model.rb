module RocketCMS
  module Model
    extend ActiveSupport::Concern
    included do
      if RocketCMS.mongoid?
        include Mongoid::Document
        include Mongoid::Timestamps::Short
      end
      include ActiveModel::ForbiddenAttributesProtection
      include BooleanField
      include SortField

      if RocketCMS.mongoid?
        include Mongoid::Paperclip
      end

      include SmartExcerpt
      if defined?(SimpleCaptcha)
        include SimpleCaptcha::ModelHelpers
      end

      if RocketCMS.mongoid? && defined?(Trackable)
        include Trackable
      end
    end
  end
end
