module RocketCMS
  module Model
    extend ActiveSupport::Concern
    included do
      include Mongoid::Document
      include Mongoid::Timestamps::Short
      include ActiveModel::ForbiddenAttributesProtection
      include Trackable
      include BooleanField
      include SortField
      include Mongoid::Paperclip
      include SmartExcerpt
      include SimpleCaptcha::ModelHelpers
    end
  end
end
