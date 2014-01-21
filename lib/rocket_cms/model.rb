module RocketCMS
  module Model
    extend ActiveSupport::Concern
    included do
      include Mongoid::Document
      include Mongoid::Timestamps::Short
      include ActiveModel::ForbiddenAttributesProtection
      include Trackable
      include Enableable
      include Mongoid::Paperclip
    end
  end
end
