module BooleanField
  extend ActiveSupport::Concern
  module ClassMethods
    def boolean_field(name, default = true)
      if RocketCMS.mongoid?
        field name, type: Mongoid::Boolean, default: default
      end
      scope name, -> { where(name => true) }
    end
  end
end
