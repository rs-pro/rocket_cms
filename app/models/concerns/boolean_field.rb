module BooleanField
  extend ActiveSupport::Concern
  module ClassMethods
    def boolean_field(name, default = true)
      field name, type: Mongoid::Boolean, default: default
      scope name, -> { where(name => true) }
    end
  end
end
